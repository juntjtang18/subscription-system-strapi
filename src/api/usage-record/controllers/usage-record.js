'use strict';

const { createCoreController } = require('@strapi/strapi').factories;
const { verifyInternalHmac } = require('../../../utils/hmac-auth');
const logger = require('../../../utils/logger');

module.exports = createCoreController('api::usage-record.usage-record', ({ strapi }) => ({
  async ingestEvent(ctx) {
    verifyInternalHmac(ctx);

    const { eventId, event_id, eventName, event_name, userId, user_id, username, payload } = ctx.request.body || {};
    const result = await strapi.service('api::usage-record.usage-record').processEvent({
      eventId: eventId || event_id,
      eventName: eventName || event_name,
      userId: userId || user_id,
      username,
      payload: payload || {},
    });

    return { data: result, meta: {} };
  },

  async getUsage(ctx) {
    verifyInternalHmac(ctx);

    const userId = ctx.query.userId || ctx.query.user_id;
    if (!userId) return ctx.badRequest('userId is required.');

    try {
      const data = await strapi.service('api::usage-record.usage-record').getUsageForUser(userId);
      return { data, meta: {} };
    } catch (error) {
      logger.error(`[usage-record.getUsage] ${error.message}`);
      throw error;
    }
  },

  async getUsageByMetric(ctx) {
    verifyInternalHmac(ctx);

    const userId = ctx.query.userId || ctx.query.user_id;
    const { metric } = ctx.params;
    if (!userId) return ctx.badRequest('userId is required.');

    const data = await strapi.service('api::usage-record.usage-record').getUsageForUser(userId, metric);
    return { data, meta: {} };
  },
}));
