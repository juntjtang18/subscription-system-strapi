'use strict';

const { ApplicationError } = require('@strapi/utils').errors;
const { createCoreService } = require('@strapi/strapi').factories;
const jwt = require('jsonwebtoken');
const axios = require('axios');
const { Buffer } = require('buffer');

// Read the Apple environment setting. Default to 'sandbox' for safety.
const APPLE_ENVIRONMENT = process.env.APPLE_ENVIRONMENT || 'sandbox';
const APPLE_API_BASE_URL = APPLE_ENVIRONMENT === 'production'
  ? 'https://api.storekit.itunes.apple.com'
  : 'https://api.storekit-sandbox.itunes.apple.com';

// Read the mock environment variable
const APPLE_CONNECT_MOCK = process.env.APPLE_CONNECT_MOCK === 'true';

module.exports = createCoreService('api::subscription.subscription', ({ strapi }) => ({

  /**
   * Generates a signed JWT to authenticate with the App Store Server API.
   */
  generateAppleApiToken() {
    const privateKey = process.env.APPLE_PRIVATE_KEY;
    const issuerId = process.env.APPLE_ISSUER_ID;
    const keyId = process.env.APPLE_KEY_ID;
    const bundleId = process.env.APPLE_BUNDLE_ID;

    if (!privateKey || !issuerId || !keyId || !bundleId) {
      console.error('Apple API credentials are not configured in environment variables.');
      throw new ApplicationError('Server configuration error for Apple API.');
    }

    const formattedPrivateKey = privateKey.replace(/\\n/g, '\n');
    const payload = { iss: issuerId, iat: Math.floor(Date.now() / 1000), exp: Math.floor(Date.now() / 1000) + (5 * 60), aud: 'appstoreconnect-v1', bid: bundleId };
    const options = { algorithm: 'ES256', header: { alg: 'ES256', kid: keyId, typ: 'JWT' } };
    return jwt.sign(payload, formattedPrivateKey, options);
  },

  /**
   * Helper function to connect to the real Apple API.
   * @param {string} transactionId - The transaction ID to verify.
   * @returns {Promise<object>} The verified transaction data from Apple.
   */
  async getRealVerifiedTransaction(transactionId) {
    const appleApiToken = this.generateAppleApiToken();
    try {
      const url = `${APPLE_API_BASE_URL}/inApps/v2/transactions/${transactionId}`;
      const response = await axios.get(url, { headers: { 'Authorization': `Bearer ${appleApiToken}` } });
      const signedTransactionInfo = response.data.signedTransactionInfo;
      const payload = signedTransactionInfo.split('.')[1];
      const decodedPayload = Buffer.from(payload, 'base64').toString('utf8');
      return JSON.parse(decodedPayload);
    } catch (error) {
      console.error("Apple API Error:", error.response?.data || error.message);
      throw new ApplicationError('Failed to verify purchase with Apple.');
    }
  },

  /**
   * Generates mock transaction data for local testing.
   * @returns {object} A fake verified transaction object.
   */
  getMockVerifiedTransaction() {
    console.log(` MOCKING APPLE API SUCCESS (Env: ${APPLE_ENVIRONMENT}, URL would be: ${APPLE_API_BASE_URL}) `);
    return {
      productId: 'ca.geniusparentingai.basic.yearlyplan', // IMPORTANT: Make sure this plan productId exists in your Strapi plans
      expiresDate: new Date().getTime() + 30 * 24 * 60 * 60 * 1000,
      originalTransactionId: 'mock-original-' + Date.now(), // Unique ID for each mock run
      purchaseDate: new Date().getTime(),
    };
  },

  /**
   * Verifies an Apple App Store receipt, and creates or updates the user's subscription.
   */
  async verifyApplePurchase({ receipt, userId }) {
    let decodedTransaction;
    try {
      const payload = receipt.split('.')[1];
      decodedTransaction = JSON.parse(Buffer.from(payload, 'base64').toString('utf8'));
    } catch (e) {
      throw new ApplicationError('Invalid receipt format.');
    }

    if (decodedTransaction.appAccountToken !== userId) {
      throw new ApplicationError('User ID does not match the purchase receipt.');
    }
    
    const { transactionId } = decodedTransaction;
    if (!transactionId) {
      throw new ApplicationError('Could not find transactionId in receipt.');
    }

    // Use the environment variable to decide which function to call
    const verifiedTransaction = APPLE_CONNECT_MOCK
      ? this.getMockVerifiedTransaction()
      : await this.getRealVerifiedTransaction(transactionId);
    
    // --- The rest of the function continues as before ---
    const { productId, expiresDate, originalTransactionId, purchaseDate } = verifiedTransaction;
    if (!productId || !expiresDate) {
      throw new ApplicationError('Missing product or expiration info from Apple.');
    }

    const plans = await strapi.entityService.findMany('api::plan.plan', { filters: { productId } });
    if (!plans || plans.length === 0) {
      throw new ApplicationError(`Plan with Product ID '${productId}' not found in our system.`);
    }
    const plan = plans[0];

    const existingSubscriptions = await strapi.entityService.findMany('api::subscription.subscription', { filters: { originalTransactionId } });
    const existingSubscription = existingSubscriptions.length > 0 ? existingSubscriptions[0] : null;

    const subscriptionData = { strapiUserId: userId, plan: plan.id, status: 'active', startDate: new Date(purchaseDate).toISOString(), expireDate: new Date(expiresDate).toISOString(), originalTransactionId, latestTransactionId: transactionId, publishedAt: new Date().toISOString() };
    
    if (existingSubscription) {
      const otherSubscriptions = await strapi.entityService.findMany('api::subscription.subscription', { filters: { strapiUserId: userId, status: 'active', originalTransactionId: { $ne: originalTransactionId } } });
      for (const sub of otherSubscriptions) {
        await strapi.entityService.update('api::subscription.subscription', sub.id, { data: { status: 'canceled' } });
      }
      await strapi.entityService.update('api::subscription.subscription', existingSubscription.id, { data: subscriptionData });
    } else {
      await strapi.entityService.create('api::subscription.subscription', { data: subscriptionData });
    }

    // Service's job is done. The controller will handle the response.
    return;
  },

  /**
   * Subscribes a user to the free plan.
   */
  async subscribeFreePlan(userId) {
    const plans = await strapi.entityService.findMany('api::plan.plan', {
      filters: { name: 'Free Plan' },
    });
    if (!plans || plans.length === 0) {
      throw new ApplicationError("Free plan not found. Please ensure a 'Free Plan' exists.");
    }
    const freePlan = plans[0];

    const existingSubscriptions = await strapi.entityService.findMany('api::subscription.subscription', {
      filters: { strapiUserId: userId, status: 'active' },
    });
    for(const sub of existingSubscriptions) {
      await strapi.entityService.update('api::subscription.subscription', sub.id, {
        data: { status: 'canceled' },
      });
    }
    
    return await strapi.entityService.create('api::subscription.subscription', {
      data: {
        strapiUserId: userId,
        plan: freePlan.id,
        status: 'active',
        startDate: new Date().toISOString(),
        expireDate: null,
      },
    });
  },

  /**
   * Subscribes a user to a specific plan (for internal use).
   */
  async subscribeToPlan({ userId, planId }) {
    const plan = await strapi.entityService.findOne('api::plan.plan', planId);
    if (!plan) {
      throw new ApplicationError('The specified plan does not exist.');
    }

    const existingSubscriptions = await strapi.entityService.findMany('api::subscription.subscription', {
      filters: { strapiUserId: userId, status: 'active' },
      populate: { plan: true }
    });
    const existingSubscription = existingSubscriptions.length > 0 ? existingSubscriptions[0] : null;

    let expireDate = null;
    if (plan.name !== 'Free') {
      const date = new Date();
      date.setDate(date.getDate() + 30);
      expireDate = date.toISOString();
    }

    if (existingSubscription) {
      if (existingSubscription.plan.id === plan.id) {
        return await strapi.entityService.update('api::subscription.subscription', existingSubscription.id, {
          data: { expireDate: expireDate },
        });
      }
      await strapi.entityService.update('api::subscription.subscription', existingSubscription.id, {
        data: { status: 'canceled' },
      });
    }

    return await strapi.entityService.create('api::subscription.subscription', {
      data: {
        strapiUserId: userId,
        plan: plan.id,
        status: 'active',
        startDate: new Date().toISOString(),
        expireDate: expireDate,
      },
    });
  },

}));