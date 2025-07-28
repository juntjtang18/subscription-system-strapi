'use strict';

const { ApplicationError } = require('@strapi/utils').errors;
const { createCoreService } = require('@strapi/strapi').factories;
const jwt = require('jsonwebtoken');
const axios = require('axios');
const { Buffer } = require('buffer');
const logger = require('../../../utils/logger');
const { verifyAppleJWS } = require('../../../utils/apple-jws-verifier');
const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

// Environment Variables
const APPLE_ENVIRONMENT = process.env.APPLE_ENVIRONMENT || 'sandbox';
const APPLE_API_BASE_URL = APPLE_ENVIRONMENT === 'production'
  ? 'https://api.storekit.itunes.apple.com'
  : 'https://api.storekit-sandbox.itunes.apple.com';
const APPLE_CONNECT_MOCK = process.env.APPLE_CONNECT_MOCK === 'true';

module.exports = createCoreService('api::subscription.subscription', ({ strapi }) => ({

  // --- HELPER FUNCTIONS ---

  generateAppleApiToken() {
    const privateKey = process.env.APPLE_PRIVATE_KEY;
    const issuerId = process.env.APPLE_ISSUER_ID;
    const keyId = process.env.APPLE_KEY_ID;
    const bundleId = process.env.APPLE_BUNDLE_ID;
    if (!privateKey || !issuerId || !keyId || !bundleId) {
      logger.error('Apple API credentials are not configured in environment variables.');
      throw new ApplicationError('Server configuration error for Apple API.');
    }
    const formattedPrivateKey = privateKey.replace(/\\n/g, '\n');
    const payload = { iss: issuerId, iat: Math.floor(Date.now() / 1000), exp: Math.floor(Date.now() / 1000) + (5 * 60), aud: 'appstoreconnect-v1', bid: bundleId };
    const options = { algorithm: 'ES256', header: { alg: 'ES256', kid: keyId, typ: 'JWT' } };
    return jwt.sign(payload, formattedPrivateKey, options);
  },

  generateExpectedAppAccountToken(userId) {
    let hexString = Number(userId).toString(16).padStart(32, '0');
    const parts = [
      hexString.substring(0, 8),
      hexString.substring(8, 12),
      hexString.substring(12, 16),
      hexString.substring(16, 20),
      hexString.substring(20, 32),
    ];
    return parts.join('-').toLowerCase();
  },

  async cancelOtherActiveSubscriptions(userId, currentSubscriptionId) {
    logger.debug(`[SVC] cancelOtherActiveSubscriptions: Cleaning up old subscriptions for user ${userId}, keeping sub ${currentSubscriptionId} active.`);

    const subscriptionsToCancel = await strapi.entityService.findMany('api::subscription.subscription', {
      filters: {
        strapiUserId: userId,
        status: 'active',
        id: {
          $ne: currentSubscriptionId,
        },
      },
    });

    if (subscriptionsToCancel.length > 0) {
      for (const sub of subscriptionsToCancel) {
        await strapi.entityService.update('api::subscription.subscription', sub.id, {
          data: { status: 'canceled' },
        });
      }
    }
  },

  // --- CORE SERVICE FUNCTIONS ---

  async verifyApplePurchase({ receipt, userId }) {
    logger.debug(`[SVC] verifyApplePurchase for userId: ${userId}`);

    // 1. Verify the JWS signature locally. This is the source of truth for immediate activation.
    let decodedTransaction;
    try {
        decodedTransaction = await verifyAppleJWS(receipt);
        logger.debug('[SVC] Local JWS verification successful:', decodedTransaction);
    } catch (error) {
        logger.error(`[SVC] Local JWS verification failed: ${error.message}`);
        throw new ApplicationError('Invalid purchase receipt.');
    }

    // 2. Validate the user ID from the token
    const expectedToken = this.generateExpectedAppAccountToken(userId);
    const receivedToken = decodedTransaction.appAccountToken;

    if (receivedToken && receivedToken.toLowerCase() !== expectedToken) {
        throw new ApplicationError('User ID does not match the purchase receipt.');
    }

    // Use the locally verified data for immediate activation
    const { expiresDate, originalTransactionId, purchaseDate, transactionId, productId } = decodedTransaction;

    if (!productId || !expiresDate) {
        throw new ApplicationError('Missing product or expiration info from decoded receipt.');
    }

    const [plan] = await strapi.entityService.findMany('api::plan.plan', {
        filters: { productId },
        limit: 1,
    });

    if (!plan) {
        throw new ApplicationError(`Plan with Product ID '${productId}' not found in our system.`);
    }

    const subscriptionData = {
        strapiUserId: userId,
        plan: plan.id,
        status: 'active',
        startDate: new Date(purchaseDate).toISOString(),
        expireDate: new Date(expiresDate).toISOString(),
        originalTransactionId,
        latestTransactionId: transactionId,
    };

    // 3. Create the new subscription and deactivate old ones
    const savedSubscription = await strapi.entityService.create('api::subscription.subscription', { data: subscriptionData });
    await this.cancelOtherActiveSubscriptions(userId, savedSubscription.id);

    // 4. Persist the receipt for the background verification job
    try {
      await strapi.entityService.create('api::apple-receipt.apple-receipt', {
        data: {
          transactionId: decodedTransaction.transactionId,
          userId: userId,
          rawReceipt: receipt,
          status: 'pending_verification',
        },
      });
      logger.info(`[SVC] Saved receipt for transaction ${decodedTransaction.transactionId} for background verification.`);
    } catch (error) {
      // Log as a critical error but do not fail the request, as the user is already activated.
      logger.error(`[SVC] CRITICAL: Failed to save receipt for background job. TID: ${decodedTransaction.transactionId}`, error);
    }

    logger.debug(`[SVC] --- Database update complete. User ${userId} is now subscribed. ---`);
    return { success: true, message: 'Subscription activated successfully.' };
  },

  async subscribeFreePlan(userId) {
    logger.debug(`[SVC] subscribeFreePlan: Executing for userId: ${userId}`);
    const [freePlan] = await strapi.entityService.findMany('api::plan.plan', {
        filters: { name: 'Free Plan' },
        limit: 1,
    });
    if (!freePlan) {
      logger.error('[SVC] subscribeFreePlan: "Free Plan" not found in database.');
      throw new ApplicationError("Free plan not found. Please ensure a 'Free Plan' exists.");
    }
    const existingSubscriptions = await strapi.entityService.findMany('api::subscription.subscription', { filters: { strapiUserId: userId, status: 'active' } });
    for (const sub of existingSubscriptions) {
      await strapi.entityService.update('api::subscription.subscription', sub.id, { data: { status: 'canceled' } });
    }
    const newSubscription = await strapi.entityService.create('api::subscription.subscription', {
        data: {
            strapiUserId: userId,
            plan: freePlan.id,
            status: 'active',
            startDate: new Date().toISOString(),
            expireDate: null
        }
    });
    return newSubscription;
  },

  async subscribeToPlan({ userId, planId }) {
    const plan = await strapi.entityService.findOne('api::plan.plan', planId);
    if (!plan) { throw new ApplicationError('The specified plan does not exist.'); }

    const [existingSubscription] = await strapi.entityService.findMany('api::subscription.subscription', {
        filters: { strapiUserId: userId, status: 'active' },
        limit: 1,
    });

    let expireDate = null;
    if (plan.name !== 'Free') { const date = new Date(); date.setDate(date.getDate() + 30); expireDate = date.toISOString(); }

    if (existingSubscription) {
        await strapi.entityService.update('api::subscription.subscription', existingSubscription.id, { data: { status: 'canceled' } });
    }
    return await strapi.entityService.create('api::subscription.subscription', {
        data: {
            strapiUserId: userId,
            plan: plan.id,
            status: 'active',
            startDate: new Date().toISOString(),
            expireDate
        }
    });
  },
}));