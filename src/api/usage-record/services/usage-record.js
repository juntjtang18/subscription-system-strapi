'use strict';

const { createCoreService } = require('@strapi/strapi').factories;
const { ApplicationError, NotFoundError } = require('@strapi/utils').errors;
const usageRuleCache = require('../../../utils/usage-rule-cache');

function startOfUtcDay(date) {
  return new Date(Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate()));
}

function addUtc(date, field, amount) {
  const next = new Date(date.getTime());
  if (field === 'minute') next.setUTCMinutes(next.getUTCMinutes() + amount);
  if (field === 'hour') next.setUTCHours(next.getUTCHours() + amount);
  if (field === 'day') next.setUTCDate(next.getUTCDate() + amount);
  if (field === 'month') next.setUTCMonth(next.getUTCMonth() + amount);
  if (field === 'year') next.setUTCFullYear(next.getUTCFullYear() + amount);
  return next;
}

function calculatePeriod(resetPeriod, now = new Date()) {
  if (resetPeriod === 'lifetime') {
    return { periodStart: new Date('1970-01-01T00:00:00.000Z'), periodEnd: new Date('9999-12-31T00:00:00.000Z') };
  }

  if (resetPeriod === 'minute') {
    const start = new Date(now); start.setUTCSeconds(0, 0);
    return { periodStart: start, periodEnd: addUtc(start, 'minute', 1) };
  }
  if (resetPeriod === 'hour') {
    const start = new Date(now); start.setUTCMinutes(0, 0, 0);
    return { periodStart: start, periodEnd: addUtc(start, 'hour', 1) };
  }
  if (resetPeriod === 'day') {
    const start = startOfUtcDay(now);
    return { periodStart: start, periodEnd: addUtc(start, 'day', 1) };
  }
  if (resetPeriod === 'week') {
    const start = startOfUtcDay(now);
    const day = start.getUTCDay();
    const diff = day === 0 ? -6 : 1 - day;
    start.setUTCDate(start.getUTCDate() + diff);
    return { periodStart: start, periodEnd: addUtc(start, 'day', 7) };
  }
  if (resetPeriod === 'two weeks') {
    const start = startOfUtcDay(now);
    const epoch = startOfUtcDay(new Date('1970-01-05T00:00:00.000Z')); // Monday
    const days = Math.floor((start - epoch) / 86400000);
    const offset = days % 14;
    start.setUTCDate(start.getUTCDate() - offset);
    return { periodStart: start, periodEnd: addUtc(start, 'day', 14) };
  }
  if (resetPeriod === 'month') {
    const start = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), 1));
    return { periodStart: start, periodEnd: addUtc(start, 'month', 1) };
  }
  if (resetPeriod === 'year') {
    const start = new Date(Date.UTC(now.getUTCFullYear(), 0, 1));
    return { periodStart: start, periodEnd: addUtc(start, 'year', 1) };
  }

  throw new ApplicationError(`Unsupported resetPeriod: ${resetPeriod}`);
}

function matchesFilter(payload, filterJson) {
  if (!filterJson || Object.keys(filterJson).length === 0) return true;
  return Object.entries(filterJson).every(([key, expected]) => {
    const actual = key.split('.').reduce((value, part) => value && value[part], payload || {});
    if (expected && typeof expected === 'object' && !Array.isArray(expected)) {
      return matchesFilter(actual, expected);
    }
    return actual === expected;
  });
}

module.exports = createCoreService('api::usage-record.usage-record', ({ strapi }) => ({
  calculatePeriod,

  normalizeEventInput({ eventId, eventName, userId, username, payload, occurredAt }) {
    const normalizedUserId = Number(userId);

    if (!eventId || !eventName || !userId) {
      throw new ApplicationError('eventId, eventName, and userId are required.');
    }

    if (!Number.isFinite(normalizedUserId)) {
      throw new ApplicationError('userId must be numeric.');
    }

    const normalizedOccurredAt = occurredAt ? new Date(occurredAt) : new Date();
    if (Number.isNaN(normalizedOccurredAt.getTime())) {
      throw new ApplicationError('occurredAt must be a valid date.');
    }

    return {
      eventId: String(eventId),
      eventName: String(eventName),
      userId: normalizedUserId,
      username: username || null,
      payload: payload || {},
      occurredAt: normalizedOccurredAt,
    };
  },

  async getActiveSubscription(userId) {
    const [subscription] = await strapi.entityService.findMany('api::subscription.subscription', {
      filters: { strapiUserId: Number(userId), status: 'active' },
      populate: { plan: true },
      sort: { createdAt: 'desc' },
      limit: 1,
    });
    if (!subscription) throw new NotFoundError('No active subscription found for this user.');
    return subscription;
  },

  async getPlanEntitlements(planId, cache = new Map()) {
    if (cache.has(planId)) return cache.get(planId);

    const plan = await strapi.entityService.findOne('api::plan.plan', planId, {
      populate: {
        inherit_from: true,
        plan_ent_links: { populate: { entitlement: true } },
      },
    });
    if (!plan) throw new NotFoundError('Plan not found.');

    const entitlements = new Map();
    if (plan.inherit_from?.id) {
      const inherited = await this.getPlanEntitlements(plan.inherit_from.id, cache);
      inherited.forEach((value, key) => entitlements.set(key, value));
    }

    (plan.plan_ent_links || []).forEach((link) => {
      if (!link.entitlement) return;
      entitlements.set(link.entitlement.slug, {
        id: link.entitlement.id,
        name: link.entitlement.name,
        slug: link.entitlement.slug,
        isMetered: link.entitlement.ismetered,
        limit: link.limitOverride !== null && link.limitOverride !== undefined ? link.limitOverride : link.entitlement.defaultlimit,
        resetPeriod: link.entitlement.resetPeriod,
      });
    });

    cache.set(planId, entitlements);
    return entitlements;
  },

  async incrementUsage({ userId, entitlement, amount, consumedAt = new Date() }) {
    const period = calculatePeriod(entitlement.resetPeriod, consumedAt);
    const filters = {
      strapiUserId: Number(userId),
      entitlement: entitlement.id,
      periodStart: period.periodStart.toISOString(),
      periodEnd: period.periodEnd.toISOString(),
    };

    const [existing] = await strapi.entityService.findMany('api::usage-record.usage-record', { filters, limit: 1 });
    if (existing) {
      return await strapi.entityService.update('api::usage-record.usage-record', existing.id, {
        data: { usedAmount: Number(existing.usedAmount || 0) + Number(amount || 1) },
      });
    }

    return await strapi.entityService.create('api::usage-record.usage-record', {
      data: {
        strapiUserId: Number(userId),
        entitlement: entitlement.id,
        periodStart: period.periodStart.toISOString(),
        periodEnd: period.periodEnd.toISOString(),
        usedAmount: Number(amount || 1),
      },
    });
  },

  async getRulesForEvent(eventName) {
    const cachedRules = usageRuleCache.getRulesForEvent(eventName);
    if (cachedRules !== null) {
      return cachedRules;
    }

    const rules = await strapi.entityService.findMany('api::usage-rule.usage-rule', {
      filters: { eventName, enabled: true },
      populate: { entitlement: true },
    });

    return rules.filter((rule) => rule.entitlement);
  },

  async processEvent(input) {
    const { eventId, eventName, userId, username, payload, occurredAt } = this.normalizeEventInput(input);

    const existingEvents = await strapi.entityService.findMany('api::usage-event.usage-event', {
      filters: { eventId },
      limit: 1,
    });
    if (existingEvents.length > 0) {
      return { duplicate: true, usageEvent: existingEvents[0] };
    }

    const usageEvent = await strapi.entityService.create('api::usage-event.usage-event', {
      data: {
        eventId,
        event_name: eventName,
        strapiUserId: Number(userId),
        username,
        payload,
        status: 'received',
      },
    });

    try {
      const rules = input.rules || await this.getRulesForEvent(eventName);
      const matchedRules = rules.filter((rule) => rule.entitlement && matchesFilter(payload, rule.filterJson));
      if (matchedRules.length === 0) {
        await strapi.entityService.update('api::usage-event.usage-event', usageEvent.id, {
          data: {
            status: 'skipped',
            handle_result: 'No matching usage rules.',
            handled_at: new Date().toISOString(),
          },
        });
        return { duplicate: false, processed: 0 };
      }

      const records = [];
      for (const rule of matchedRules) {
        const entitlement = rule.entitlement;
        await strapi.entityService.create('api::usageledger.usageledger', {
          data: {
            strapiUserId: Number(userId),
            entitlement: entitlement.id,
            consumedAt: occurredAt.toISOString(),
            amount: Number(rule.amount || 1),
          },
        });
        records.push(await this.incrementUsage({ userId, entitlement, amount: rule.amount || 1, consumedAt: occurredAt }));
      }

      await strapi.entityService.update('api::usage-event.usage-event', usageEvent.id, {
        data: {
          status: 'processed',
          handle_result: `Matched ${matchedRules.length} rule(s).`,
          handled_at: new Date().toISOString(),
        },
      });

      return { duplicate: false, processed: records.length, records };
    } catch (error) {
      await strapi.entityService.update('api::usage-event.usage-event', usageEvent.id, {
        data: {
          status: 'failed',
          handle_result: error.message,
          handled_at: new Date().toISOString(),
        },
      });
      throw error;
    }
  },

  async processEventFromBus({ topic, payload, publishedAt }) {
    const eventPayload = payload || {};

    return await this.processEvent({
      eventId: eventPayload.eventId || eventPayload.event_id,
      eventName: eventPayload.eventName || eventPayload.event_name || topic,
      userId: eventPayload.userId || eventPayload.user_id,
      username: eventPayload.username,
      payload: {
        ...eventPayload,
        _meta: {
          ...(eventPayload._meta || {}),
          source: 'event-bus',
          topic,
          publishedAt: publishedAt || null,
        },
      },
      occurredAt: publishedAt || new Date().toISOString(),
    });
  },

  async getUsageForUser(userId, metricSlug) {
    const subscription = await this.getActiveSubscription(userId);
    const entitlements = await this.getPlanEntitlements(subscription.plan.id);
    const now = new Date();
    const result = [];

    for (const entitlement of entitlements.values()) {
      if (!entitlement.isMetered) continue;
      if (metricSlug && entitlement.slug !== metricSlug) continue;

      const period = calculatePeriod(entitlement.resetPeriod, now);
      const [record] = await strapi.entityService.findMany('api::usage-record.usage-record', {
        filters: {
          strapiUserId: Number(userId),
          entitlement: entitlement.id,
          periodStart: period.periodStart.toISOString(),
          periodEnd: period.periodEnd.toISOString(),
        },
        limit: 1,
      });

      const used = Number(record?.usedAmount || 0);
      const limit = entitlement.limit === null || entitlement.limit === undefined ? null : Number(entitlement.limit);
      result.push({
        metric: entitlement.slug,
        name: entitlement.name,
        used,
        limit,
        remaining: limit === null ? null : Math.max(limit - used, 0),
        resetPeriod: entitlement.resetPeriod,
        periodStart: period.periodStart.toISOString(),
        periodEnd: period.periodEnd.toISOString(),
      });
    }

    if (metricSlug && result.length === 0) throw new NotFoundError('Usage metric not found for current plan.');
    return metricSlug ? result[0] : result;
  },
}));
