// ./src/api/subscription/controllers/subscription.js

'use strict';

/**
 * subscription controller
 */

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::subscription.subscription', ({ strapi }) => ({
  /**
   * Creates a free tier subscription for a user.
   * @param {object} ctx - The Koa context.
   */
  async subscribeFreePlan(ctx) {
    const { userId } = ctx.request.body;

    if (!userId) {
      return ctx.badRequest('User ID is missing');
    }

    try {
      const subscription = await strapi
        .service('api::subscription.subscription')
        .subscribeFreePlan(userId);

      const sanitizedSubscription = await this.sanitizeOutput(subscription, ctx);
      return this.transformResponse(sanitizedSubscription);
    } catch (error) {
      if (error.name === 'ApplicationError') {
        return ctx.badRequest(error.message);
      }
      console.error(error);
      return ctx.internalServerError('An unexpected error occurred.');
    }
  },

  /**
   * Creates a subscription to a specific plan for a user.
   * @param {object} ctx - The Koa context.
   */
  async subscribeToPlan(ctx) {
    const { userId, planId } = ctx.request.body;

    if (!userId || !planId) {
      return ctx.badRequest('User ID and Plan ID are required.');
    }

    try {
      const subscription = await strapi
        .service('api::subscription.subscription')
        .subscribeToPlan({ userId, planId });

      const sanitizedSubscription = await this.sanitizeOutput(subscription, ctx);
      return this.transformResponse(sanitizedSubscription);
    } catch (error) {
      if (error.name === 'ApplicationError') {
        return ctx.badRequest(error.message);
      }
      console.error(error);
      return ctx.internalServerError('An unexpected error occurred.');
    }
  },
}));
