// ./src/api/subscription/services/subscription.js

'use strict';

const { ApplicationError } = require('@strapi/utils').errors;
const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::subscription.subscription', ({ strapi }) => ({
  /**
   * Subscribes a user to the free plan. Deactivates any existing subscription
   * and creates a new one for the free plan.
   * @param {number} userId - The ID of the user.
   * @returns {Promise<object>} The created subscription object.
   */
  async subscribeFreePlan(userId) {
    // Find the 'Free' plan
    const freePlan = await strapi.db.query('api::plan.plan').findOne({
      where: { name: 'Free Plan' },
    });

    if (!freePlan) {
      throw new ApplicationError("Free plan not found. Please ensure a 'Free' plan exists.");
    }

    // Deactivate any existing active subscription for this user
    const existingSubscription = await strapi.db.query('api::subscription.subscription').findOne({
      where: { strapiUserId: userId, status: 'active' },
    });

    if (existingSubscription) {
      await strapi.entityService.update('api::subscription.subscription', existingSubscription.id, {
        data: {
          status: 'canceled', // Set old subscription to 'canceled'
        },
      });
    }

    // Create a new subscription for the Free plan
    const newSubscription = await strapi.entityService.create('api::subscription.subscription', {
      data: {
        strapiUserId: userId,
        plan: freePlan.id,
        status: 'active',
        startDate: new Date().toISOString(), // Set the start date
        expireDate: null,
      },
    });

    return newSubscription;
  },

  /**
   * Subscribes a user to a specific plan. If the user is re-subscribing to the same
   * active plan, it extends the expiration date. Otherwise, it deactivates the old
   * subscription and creates a new one.
   * @param {object} params - The function parameters.
   * @param {number} params.userId - The ID of the user.
   * @param {number} params.planId - The ID of the plan.
   * @returns {Promise<object>} The created or updated subscription object.
   */
  async subscribeToPlan({ userId, planId }) {
    // 1. Validate the target plan exists
    const plan = await strapi.db.query('api::plan.plan').findOne({
      where: { id: planId },
    });

    if (!plan) {
      throw new ApplicationError('The specified plan does not exist.');
    }

    // 2. Find any existing active subscription for this user
    const existingSubscription = await strapi.db.query('api::subscription.subscription').findOne({
      where: { strapiUserId: userId, status: 'active' },
      populate: { plan: true } // Populate plan to get its ID
    });
    
    // 3. Calculate the new expiration date
    let expireDate = null;
    if (plan.name !== 'Free') {
      const date = new Date();
      date.setDate(date.getDate() + 30);
      expireDate = date.toISOString();
    }

    // 4. Handle logic if a subscription already exists
    if (existingSubscription) {
      // CASE A: User is re-subscribing to the SAME plan
      // We just extend their expiration date. The start date remains the same.
      if (existingSubscription.plan.id === plan.id) {
        return await strapi.entityService.update('api::subscription.subscription', existingSubscription.id, {
          data: { expireDate: expireDate },
        });
      }

      // CASE B: User is changing plans (upgrade/downgrade)
      // We deactivate the old one first.
      await strapi.entityService.update('api::subscription.subscription', existingSubscription.id, {
        data: {
          status: 'canceled',
        },
      });
    }

    // 5. Create the new active subscription
    const newSubscription = await strapi.entityService.create('api::subscription.subscription', {
      data: {
        strapiUserId: userId,
        plan: plan.id,
        status: 'active',
        startDate: new Date().toISOString(), // Set the start date
        expireDate: expireDate,
      },
    });

    return newSubscription;
  },

  /**
   * Verifies an Apple App Store receipt.
   * @param {string} receipt - The JWS representation of the receipt.
   * @returns {Promise<object>} The verification result.
   */
  async verifyApplePurchase(receipt) {
    // TODO: Implement communication with Apple's App Store Server API
    // 1. Send the receipt to Apple's verification endpoint.
    // 2. Handle the response from Apple.
    // 3. If the receipt is valid, extract the productID and expiresDate.
    // 4. Update the user's subscription in your database based on the verified details.

    console.log('Verifying Apple purchase with receipt:', receipt);
    
    // This is a placeholder response.
    // You should replace this with the actual data from Apple's API.
    const appleVerificationResult = {
      productId: 'com.yourapp.product1',
      expiresDate: new Date(new Date().getTime() + 30 * 24 * 60 * 60 * 1000), // e.g., 30 days from now
      isValid: true,
    };
    
    if(!appleVerificationResult.isValid) {
      throw new ApplicationError("Invalid receipt");
    }

    // Here you can add logic to update the user's subscription
    // based on the appleVerificationResult

    return appleVerificationResult;
  },
}));