'use strict';

const { ApplicationError } = require('@strapi/utils').errors;
const { createCoreService } = require('@strapi/strapi').factories;
const jwt = require('jsonwebtoken');
const axios = require('axios');
const { Buffer } = require('buffer');
const logger = require('../../../utils/logger');
const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

// Environment Variables
const APPLE_ENVIRONMENT = process.env.APPLE_ENVIRONMENT || 'sandbox';
const APPLE_API_BASE_URL = APPLE_ENVIRONMENT === 'production'
  ? 'https://api.storekit.itunes.apple.com'
  : 'https://api.storekit-sandbox.itunes.apple.com';
const APPLE_CONNECT_MOCK = process.env.APPLE_CONNECT_MOCK === 'true';
const APPLE_API_VERSION = process.env.APPLE_API_VERSION || 'v2';

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

  async getVerifiedTransaction(decodedTransaction) {
    if (APPLE_CONNECT_MOCK) {
        return {
            productId: 'ca.geniusparentingai.basic.monthly',
            expiresDate: new Date().getTime() + 30 * 24 * 60 * 60 * 1000,
            originalTransactionId: 'mock-original-' + Date.now(),
            purchaseDate: new Date().getTime(),
        };
    }

    const { transactionId, originalTransactionId } = decodedTransaction;
    const appleApiToken = this.generateAppleApiToken();
    let url = `${APPLE_API_BASE_URL}/inApps/v2/transactions/${transactionId}`;
    if (APPLE_API_VERSION === 'v1_history' && originalTransactionId) {
        url = `${APPLE_API_BASE_URL}/inApps/v1/history/${originalTransactionId}`;
    }


    for (let attempt = 1; attempt <= 3; attempt++) {
        try {
            const response = await axios.get(url, { headers: { 'Authorization': `Bearer ${appleApiToken}` } });
            const signedTransactions = response.data.signedTransactions || [response.data.signedTransactionInfo];

            if (!signedTransactions || signedTransactions.length === 0) {
                throw new ApplicationError('No signed transactions found in Apple API response.');
            }

            const latestTransaction = signedTransactions[signedTransactions.length - 1];
            const payload = latestTransaction.split('.')[1];
            return JSON.parse(Buffer.from(payload, 'base64').toString('utf8'));
        } catch (error) {
            if (error.response?.status === 404 && attempt < 3) {
                await sleep(attempt * 1000);
            } else {
                logger.error(`Apple API Error after all retries: ${error.response?.data || error.message}`);
                throw new ApplicationError('Failed to verify purchase with Apple.');
            }
        }
    }
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

  async decodeAndValidateReceipt(receipt, userId) {
    // Log the raw receipt data for debugging
    logger.debug('[SVC] Raw receipt data received:', receipt);
    try {
        const payload = receipt.split('.')[1];
        const decodedTransaction = JSON.parse(Buffer.from(payload, 'base64').toString('utf8'));

        // Log the decoded transaction for debugging
        logger.debug('[SVC] Decoded transaction data:', decodedTransaction);

        const expectedToken = this.generateExpectedAppAccountToken(userId);
        const receivedToken = decodedTransaction.appAccountToken;

        if (receivedToken && receivedToken.toLowerCase() === expectedToken) {
            return decodedTransaction;
        }

        const { originalTransactionId } = decodedTransaction;
        if (originalTransactionId) {
            const [existingSubscription] = await strapi.entityService.findMany('api::subscription.subscription', {
                filters: { originalTransactionId, strapiUserId: userId },
                limit: 1,
            });

            if (existingSubscription) {
                return decodedTransaction;
            }
        }

        throw new ApplicationError('User ID does not match the purchase receipt.');

    } catch (e) {
        logger.error('[SVC] verifyApplePurchase: ERROR - Failed to decode or validate receipt.', e);
        throw new ApplicationError('Invalid receipt format or validation failed.');
    }
  },


  // --- CORE SERVICE FUNCTIONS ---

  async verifyApplePurchase({ receipt, userId }) {
    logger.debug(`[SVC] verifyApplePurchase for userId: ${userId}`);

    const decodedTransaction = await this.decodeAndValidateReceipt(receipt, userId);

    const verifiedTransaction = await this.getVerifiedTransaction(decodedTransaction);
    logger.debug('[SVC] Verified transaction data received:', verifiedTransaction);

    const { expiresDate, originalTransactionId, purchaseDate, transactionId } = verifiedTransaction;

    // Conditionally select the product ID based on the environment variable
    const useV2Endpoint = process.env.APPLE_API_VERSION === 'v2';
    const productId = useV2Endpoint ? verifiedTransaction.productId : decodedTransaction.productId;

    if (!productId || !expiresDate) {
        throw new ApplicationError('Missing product or expiration info from Apple.');
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
        latestTransactionId: transactionId || decodedTransaction.transactionId,
    };

    // --- LOGIC CORRECTION ---
    // Always create a new subscription record for a new valid transaction.
    // The cancelOtherActiveSubscriptions function will handle deactivating the old one.

    const savedSubscription = await strapi.entityService.create('api::subscription.subscription', { data: subscriptionData });

    // This function will find any other 'active' subscriptions for the user and deactivate them.
    await this.cancelOtherActiveSubscriptions(userId, savedSubscription.id);

    logger.debug('[SVC] --- Database update complete. Verification successful. ---');
    return;
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