'use strict';

const { createCoreController } = require('@strapi/strapi').factories;
const { ApplicationError, NotFoundError } = require('@strapi/utils').errors;
const logger = require('../../../utils/logger'); 

module.exports = createCoreController('api::subscription.subscription', ({ strapi }) => ({
  async subscribeFreePlan(ctx) {
    const { userId } = ctx.request.body;
    logger.debug(`[CTRL] /subscribe-free-plan: Received request for userId: ${userId}`);

    if (!userId) {
      return ctx.badRequest('User ID is missing');
    }

    try {
      logger.debug(`[CTRL] /subscribe-free-plan: Calling service to create subscription.`);
      const newSubscription = await strapi.service('api::subscription.subscription').subscribeFreePlan(userId);
      logger.debug(`[CTRL] /subscribe-free-plan: Service call complete. Subscription ID: ${newSubscription.id}. Now formatting the response.`);
      
      // 1. Re-fetch the subscription with its plan relation populated.
      const subscriptionWithPlan = await strapi.entityService.findOne('api::subscription.subscription', newSubscription.id, {
          populate: { plan: true },
      });

      if (!subscriptionWithPlan.plan?.id) {
        throw new ApplicationError('Subscription created, but it has no associated plan.');
      }
      
      // 2. Fetch the full, detailed plan information.
      const planId = subscriptionWithPlan.plan.id;
      const planController = strapi.controller('api::plan.plan');
      const planResponse = await planController.findOneWithDetails({ params: { id: planId } });

      // 3. Format the final subscription object.
      const formattedSubscription = {
        id: subscriptionWithPlan.id,
        attributes: {
          strapiUserId: subscriptionWithPlan.strapiUserId,
          status: subscriptionWithPlan.status,
          expireDate: subscriptionWithPlan.expireDate,
          originalTransactionId: subscriptionWithPlan.originalTransactionId,
          latestTransactionId: subscriptionWithPlan.latestTransactionId,
          createdAt: subscriptionWithPlan.createdAt,
          updatedAt: subscriptionWithPlan.updatedAt,
          startDate: subscriptionWithPlan.startDate,
          plan: planResponse.data,
        },
      };

      // 4. Return the data directly as JSON.
      return { data: formattedSubscription, meta: {} };

    } catch (error) {
      logger.error(`[CTRL] /subscribe-free-plan: ERROR - Name: ${error.name}, Message: ${error.message}`);
      if (error.name === 'ApplicationError' || error.name === 'NotFoundError') {
        return ctx.badRequest(error.message);
      }
      return ctx.internalServerError('An unexpected error occurred.');
    }
  },

  async getSubscriptionForUser(ctx) {
    const { userId } = ctx.params;
    logger.debug(`[CTRL] getSubscriptionForUser: Executing for userId: ${userId}`);

    if (!userId) {
      return ctx.badRequest('User ID is missing');
    }

    try {
      const queryFilters = { strapiUserId: userId, status: 'active' };
      const subscriptions = await strapi.entityService.findMany('api::subscription.subscription', {
        filters: queryFilters,
        populate: { plan: true },
      });
      
      if (!subscriptions || subscriptions.length === 0) {
        throw new NotFoundError('No active subscription found for this user.');
      }

      const activeSubscription = subscriptions[0];
      
      if (!activeSubscription.plan?.id) {
        throw new ApplicationError('Subscription found, but it has no associated plan.');
      }
      
      const planId = activeSubscription.plan.id;
      const planController = strapi.controller('api::plan.plan');
      const planResponse = await planController.findOneWithDetails({ params: { id: planId } });
      const formattedSubscription = {
        id: activeSubscription.id,
        attributes: {
          strapiUserId: activeSubscription.strapiUserId,
          status: activeSubscription.status,
          expireDate: activeSubscription.expireDate,
          originalTransactionId: activeSubscription.originalTransactionId,
          latestTransactionId: activeSubscription.latestTransactionId,
          createdAt: activeSubscription.createdAt,
          updatedAt: activeSubscription.updatedAt,
          startDate: activeSubscription.startDate,
          plan: planResponse.data,
        },
      };
      return { data: formattedSubscription, meta: {} };

    } catch (error) {
      logger.error(`[CTRL] getSubscriptionForUser: ERROR - Name: ${error.name}, Message: ${error.message}`);
      throw error;
    }
  },
  
  async subscribeToPlan(ctx) {
    const { userId, planId } = ctx.request.body;
    if (!userId || !planId) { return ctx.badRequest('User ID and Plan ID are required.'); }
    try {
      await strapi.service('api::subscription.subscription').subscribeToPlan({ userId, planId });
      const newCtx = { ...ctx, params: { userId } };
      return await this.getSubscriptionForUser(newCtx);
    } catch (error) {
      if (error.name === 'ApplicationError' || error.name === 'NotFoundError') { return ctx.badRequest(error.message); }
      logger.error('Error in subscribeToPlan:', error);
      return ctx.internalServerError('An unexpected error occurred.');
    }
  },

  async verifyApplePurchase(ctx) {
    const { receipt, userId } = ctx.request.body;
    if (!receipt || !userId) { return ctx.badRequest('Receipt and User ID are required.'); }
    try {
      await strapi.service('api::subscription.subscription').verifyApplePurchase({ receipt, userId });
      const newCtx = { ...ctx, params: { userId } };
      return await this.getSubscriptionForUser(newCtx);
    } catch (error) {
      if (error.name === 'ApplicationError' || error.name === 'NotFoundError') { return ctx.badRequest(error.message); }
      logger.error('Error in verifyApplePurchase:', error);
      return ctx.internalServerError('An unexpected error occurred.');
    }
  },
}));