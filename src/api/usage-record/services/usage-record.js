'use strict';

const { createCoreService } = require('@strapi/strapi').factories;
const { ApplicationError, NotFoundError } = require('@strapi/utils').errors;

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

  async processEvent({ eventId, eventName, userId, username, payload }) {
    if (!eventId || !eventName || !userId) {
      throw new ApplicationError('eventId, eventName, and userId are required.');
    }

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
        eventName,
        strapiUserId: Number(userId),
        username,
        payload,
        status: 'received',
      },
    });

    try {
      const rules = await strapi.entityService.findMany('api::usage-rule.usage-rule', {
        filters: { eventName, enabled: true },
        populate: { entitlement: true },
      });

      const matchedRules = rules.filter((rule) => rule.entitlement && matchesFilter(payload, rule.filterJson));
      if (matchedRules.length === 0) {
        await strapi.entityService.update('api::usage-event.usage-event', usageEvent.id, {
          data: { status: 'skipped', processedAt: new Date().toISOString() },
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
            consumedAt: new Date().toISOString(),
            amount: Number(rule.amount || 1),
          },
        });
        records.push(await this.incrementUsage({ userId, entitlement, amount: rule.amount || 1 }));
      }

      await strapi.entityService.update('api::usage-event.usage-event', usageEvent.id, {
        data: { status: 'processed', processedAt: new Date().toISOString() },
      });

      return { duplicate: false, processed: records.length, records };
    } catch (error) {
      await strapi.entityService.update('api::usage-event.usage-event', usageEvent.id, {
        data: { status: 'failed', error: error.message, processedAt: new Date().toISOString() },
      });
      throw error;
    }
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
