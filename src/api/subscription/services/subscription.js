'use strict';

const { ApplicationError } = require('@strapi/utils').errors;
const { createCoreService } = require('@strapi/strapi').factories;
const jwt = require('jsonwebtoken');
const axios = require('axios');
const { Buffer } = require('buffer');
const logger = require('../../../utils/logger'); // Import the new logger

const APPLE_ENVIRONMENT = process.env.APPLE_ENVIRONMENT || 'sandbox';
const APPLE_API_BASE_URL = APPLE_ENVIRONMENT === 'production'
  ? 'https://api.storekit.itunes.apple.com'
  : 'https://api.storekit-sandbox.itunes.apple.com';
const APPLE_CONNECT_MOCK = process.env.APPLE_CONNECT_MOCK === 'true';

module.exports = createCoreService('api::subscription.subscription', ({ strapi }) => ({

  generateAppleApiToken() { /* ... unchanged ... */ },
  async getRealVerifiedTransaction(transactionId) { /* ... unchanged ... */ },
  
  getMockVerifiedTransaction() {
    logger.debug(` MOCKING APPLE API SUCCESS (Env: ${APPLE_ENVIRONMENT}, URL would be: ${APPLE_API_BASE_URL}) `);
    return {
      productId: 'com.yourcompany.pro.monthly',
      expiresDate: new Date().getTime() + 30 * 24 * 60 * 60 * 1000,
      originalTransactionId: 'mock-original-' + Date.now(),
      purchaseDate: new Date().getTime(),
    };
  },

  async verifyApplePurchase({ receipt, userId }) {
    logger.debug(`[SVC] 1. --- Starting verification for userId: ${userId} ---`);
    let decodedTransaction;
    try {
      const payload = receipt.split('.')[1];
      decodedTransaction = JSON.parse(Buffer.from(payload, 'base64').toString('utf8'));
      logger.debug(`[SVC] 2. Receipt decoded. TransactionId: ${decodedTransaction.transactionId}, AppAccountToken: ${decodedTransaction.appAccountToken}`);
    } catch (e) {
      logger.error('[SVC] 2. ERROR: Failed to decode receipt.', e);
      throw new ApplicationError('Invalid receipt format.');
    }
    const isUserIdMatch = String(decodedTransaction.appAccountToken) === String(userId);
    logger.debug(`[SVC] 3. Security Check: Is appAccountToken ('${decodedTransaction.appAccountToken}') equal to userId ('${userId}')? -> ${isUserIdMatch}`);
    if (!isUserIdMatch) { throw new ApplicationError('User ID does not match the purchase receipt.'); }
    const { transactionId } = decodedTransaction;
    if (!transactionId) {
      logger.error('[SVC] ERROR: TransactionId not found in receipt.');
      throw new ApplicationError('Could not find transactionId in receipt.');
    }
    logger.debug(`[SVC] 4. Fetching verified transaction from Apple (or mock)...`);
    const verifiedTransaction = APPLE_CONNECT_MOCK ? this.getMockVerifiedTransaction() : await this.getRealVerifiedTransaction(transactionId);
    logger.debug('[SVC] 5. Verified transaction data received:', verifiedTransaction);
    const { productId, expiresDate, originalTransactionId, purchaseDate } = verifiedTransaction;
    if (!productId || !expiresDate) {
      logger.error('[SVC] ERROR: Missing productId or expiresDate from Apple response.');
      throw new ApplicationError('Missing product or expiration info from Apple.');
    }
    logger.debug(`[SVC] 6. Looking for plan with productId: '${productId}'`);
    const plans = await strapi.entityService.findMany('api::plan.plan', { filters: { productId } });
    if (!plans || plans.length === 0) {
      logger.error(`[SVC] ERROR: Plan with productId '${productId}' not found.`);
      throw new ApplicationError(`Plan with Product ID '${productId}' not found in our system.`);
    }
    const plan = plans[0];
    logger.debug(`[SVC] 7. Found plan: ${plan.name} (ID: ${plan.id})`);
    logger.debug(`[SVC] 8. Looking for existing subscription with originalTransactionId: '${originalTransactionId}'`);
    const existingSubscriptions = await strapi.entityService.findMany('api::subscription.subscription', { filters: { originalTransactionId } });
    const existingSubscription = existingSubscriptions.length > 0 ? existingSubscriptions[0] : null;
    if (existingSubscription) { logger.debug(`[SVC] 9a. Found existing subscription (ID: ${existingSubscription.id}). This is a renewal.`); }
    else { logger.debug(`[SVC] 9b. No existing subscription found. This is a new purchase.`); }
    const subscriptionData = { strapiUserId: userId, plan: plan.id, status: 'active', startDate: new Date(purchaseDate).toISOString(), expireDate: new Date(expiresDate).toISOString(), originalTransactionId, latestTransactionId: transactionId };
    if (existingSubscription) {
      logger.debug(`[SVC] 10a. Updating subscription ID: ${existingSubscription.id}`);
      await strapi.entityService.update('api::subscription.subscription', existingSubscription.id, { data: subscriptionData });
    } else {
      logger.debug(`[SVC] 10b. Creating new subscription.`);
      await strapi.entityService.create('api::subscription.subscription', { data: subscriptionData });
    }
    logger.debug('[SVC] 11. --- Database update complete. Verification successful. ---');
    return;
  },

  async subscribeFreePlan(userId) {
    logger.debug(`[SVC] subscribeFreePlan: Executing for userId: ${userId}`);
    const plans = await strapi.entityService.findMany('api::plan.plan', { filters: { name: 'Free Plan' } });
    if (!plans || plans.length === 0) {
      logger.error('[SVC] subscribeFreePlan: "Free Plan" not found in database.');
      throw new ApplicationError("Free plan not found. Please ensure a 'Free Plan' exists.");
    }
    const freePlan = plans[0];
    logger.debug(`[SVC] subscribeFreePlan: Found "Free Plan" with ID: ${freePlan.id}`);
    const existingSubscriptions = await strapi.entityService.findMany('api::subscription.subscription', { filters: { strapiUserId: userId, status: 'active' } });
    for (const sub of existingSubscriptions) {
      logger.debug(`[SVC] subscribeFreePlan: Canceling old subscription ID: ${sub.id}`);
      await strapi.entityService.update('api::subscription.subscription', sub.id, { data: { status: 'canceled' } });
    }
    const dataToCreate = { strapiUserId: userId, plan: freePlan.id, status: 'active', startDate: new Date().toISOString(), expireDate: null };
    logger.debug('[SVC] subscribeFreePlan: Attempting to create new subscription with data:', dataToCreate);
    const newSubscription = await strapi.entityService.create('api::subscription.subscription', { data: dataToCreate });
    logger.debug(`[SVC] subscribeFreePlan: Successfully created new subscription with ID: ${newSubscription.id}`);
    return newSubscription;
  },

  async subscribeToPlan({ userId, planId }) {
    const plan = await strapi.entityService.findOne('api::plan.plan', planId);
    if (!plan) { throw new ApplicationError('The specified plan does not exist.'); }
    const existingSubscriptions = await strapi.entityService.findMany('api::subscription.subscription', { filters: { strapiUserId: userId, status: 'active' }, populate: { plan: true } });
    const existingSubscription = existingSubscriptions.length > 0 ? existingSubscriptions[0] : null;
    let expireDate = null;
    if (plan.name !== 'Free') { const date = new Date(); date.setDate(date.getDate() + 30); expireDate = date.toISOString(); }
    if (existingSubscription) {
      if (existingSubscription.plan.id === plan.id) {
        return await strapi.entityService.update('api::subscription.subscription', existingSubscription.id, { data: { expireDate } });
      }
      await strapi.entityService.update('api::subscription.subscription', existingSubscription.id, { data: { status: 'canceled' } });
    }
    return await strapi.entityService.create('api::subscription.subscription', { data: { strapiUserId: userId, plan: plan.id, status: 'active', startDate: new Date().toISOString(), expireDate } });
  },
}));