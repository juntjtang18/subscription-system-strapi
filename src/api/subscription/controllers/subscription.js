'use strict';

const { createCoreController } = require('@strapi/strapi').factories;
const { ApplicationError, NotFoundError } = require('@strapi/utils').errors;
const logger = require('../../../utils/logger'); // Import the new logger

module.exports = createCoreController('api::subscription.subscription', ({ strapi }) => ({
  async subscribeFreePlan(ctx) {
    const { userId } = ctx.request.body;
    logger.debug(`[CTRL] /subscribe-free-plan: Received request for userId: ${userId}`);

    if (!userId) {
      return ctx.badRequest('User ID is missing');
    }

    try {
      logger.debug(`[CTRL] /subscribe-free-plan: Calling service.`);
      await strapi.service('api::subscription.subscription').subscribeFreePlan(userId);
      logger.debug(`[CTRL] /subscribe-free-plan: Service call complete. Fetching full subscription.`);
      
      const newCtx = { ...ctx, params: { userId } };
      return await this.getSubscriptionForUser(newCtx);

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
      logger.debug('[CTRL] getSubscriptionForUser: Querying DB with filters:', queryFilters);
      
      const subscriptions = await strapi.entityService.findMany('api::subscription.subscription', {
        filters: queryFilters,
        populate: { plan: true },
      });
      
      logger.debug(`[CTRL] getSubscriptionForUser: DB query returned ${subscriptions.length} results.`);

      if (!subscriptions || subscriptions.length === 0) {
        logger.error('[CTRL] getSubscriptionForUser: ERROR - No active subscription found.');
        throw new NotFoundError('No active subscription found for this user.');
      }

      const activeSubscription = subscriptions[0];
      logger.debug(`[CTRL] getSubscriptionForUser: Found active subscription ID: ${activeSubscription.id}`);
      
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