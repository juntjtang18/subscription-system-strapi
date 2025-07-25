'use strict';

/**
 * subscription controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::subscription.subscription', ({ strapi }) => ({
  /**
   * Creates a free tier subscription for a user and returns the full subscription details
   * in the standard Strapi format.
   * @param {object} ctx - The Koa context.
   */
  async subscribeFreePlan(ctx) {
    const { userId } = ctx.request.body;

    if (!userId) {
      return ctx.badRequest('User ID is missing');
    }

    try {
      await strapi
        .service('api::subscription.subscription')
        .subscribeFreePlan(userId);

      const newCtx = { ...ctx, params: { userId } };
      return this.getSubscriptionForUser(newCtx);

    } catch (error) {
      if (error.name === 'ApplicationError') {
        return ctx.badRequest(error.message);
      }
      console.error('Error in subscribeFreePlan:', error);
      return ctx.internalServerError('An unexpected error occurred.');
    }
  },

  /**
   * Creates a subscription to a specific plan and returns the full subscription details
   * in the standard Strapi format.
   * @param {object} ctx - The Koa context.
   */
  async subscribeToPlan(ctx) {
    const { userId, planId } = ctx.request.body;

    if (!userId || !planId) {
      return ctx.badRequest('User ID and Plan ID are required.');
    }

    try {
      await strapi
        .service('api::subscription.subscription')
        .subscribeToPlan({ userId, planId });

      const newCtx = { ...ctx, params: { userId } };
      return this.getSubscriptionForUser(newCtx);

    } catch (error) {
      if (error.name === 'ApplicationError') {
        return ctx.badRequest(error.message);
      }
      console.error('Error in subscribeToPlan:', error);
      return ctx.internalServerError('An unexpected error occurred.');
    }
  },

  /**
   * Gets the active subscription for a user, including detailed plan information,
   * and returns it in the standard Strapi format.
   * @param {object} ctx - The Koa context.
   */
  async getSubscriptionForUser(ctx) {
    const { userId } = ctx.params;

    if (!userId) {
      return ctx.badRequest('User ID is missing');
    }

    try {
      const subscriptions = await strapi.entityService.findMany('api::subscription.subscription', {
        filters: {
          strapiUserId: userId,
          status: 'active',
        },
        populate: { plan: true },
      });

      if (!subscriptions || subscriptions.length === 0) {
        return ctx.notFound('No active subscription found for this user.');
      }

      const activeSubscription = subscriptions[0];
      
      if (!activeSubscription.plan?.id) {
        return ctx.internalServerError('Subscription found, but it has no associated plan.');
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
      console.error('Error in getSubscriptionForUser:', error);
      return ctx.internalServerError('An unexpected error occurred while fetching the subscription.');
    }
  },

  async verifyApplePurchase(ctx) {
    const { receipt, userId } = ctx.request.body;

    if (!receipt || !userId) {
      return ctx.badRequest('Receipt and User ID are required.');
    }

    try {
      // 1. Let the service handle the entire verification and database update.
      await strapi
        .service('api::subscription.subscription')
        .verifyApplePurchase({ receipt, userId });
      
      // 2. After the service succeeds, call getSubscriptionForUser to format the response.
      // This removes the circular dependency and fixes the crash.
      const newCtx = { ...ctx, params: { userId } };
      return this.getSubscriptionForUser(newCtx);

    } catch (error) {
      if (error.name === 'ApplicationError') {
        return ctx.badRequest(error.message);
      }
      console.error('Error in verifyApplePurchase:', error);
      return ctx.internalServerError('An unexpected error occurred.');
    }
  },

}));