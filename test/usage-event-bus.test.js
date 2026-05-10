'use strict';

const assert = require('assert/strict');
const crypto = require('crypto');
const createStrapi = require('@strapi/strapi').default;
const { publishUsageEvent } = require('./usage-event-bus-client');
const { refreshUsageRuleCache } = require('../src/utils/usage-rule-cache');
const { syncUsageRuleSubscriptions } = require('../src/utils/usage-event-bus');

function wait(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function waitFor(check, message, timeoutMs = 5000) {
  const startedAt = Date.now();

  while (Date.now() - startedAt < timeoutMs) {
    const result = await check();
    if (result) {
      return result;
    }

    await wait(100);
  }

  throw new Error(message);
}

function createTestPrefix() {
  return `usage-bus-${Date.now()}-${crypto.randomUUID().slice(0, 8)}`;
}

async function createPlanFixture(strapi, prefix) {
  return await strapi.entityService.create('api::plan.plan', {
    data: {
      name: `${prefix} plan`,
      productId: `${prefix}.product`,
      order: 9999,
      role: 'pro',
      locale: 'en',
    },
  });
}

async function createEntitlementFixture(strapi, prefix, name, defaultlimit) {
  return await strapi.entityService.create('api::entitlement.entitlement', {
    data: {
      name: `${prefix}-${name}`,
      slug: `${prefix}-${name}`.toLowerCase(),
      ismetered: true,
      defaultlimit,
      resetPeriod: 'month',
    },
  });
}

async function linkPlanEntitlement(strapi, planId, entitlementId, limitOverride) {
  return await strapi.entityService.create('api::plan-ent-link.plan-ent-link', {
    data: {
      plan: planId,
      entitlement: entitlementId,
      limitOverride,
    },
  });
}

async function createUsageRule(strapi, eventName, entitlementId, amount, filterJson) {
  return await strapi.entityService.create('api::usage-rule.usage-rule', {
    data: {
      eventName,
      entitlement: entitlementId,
      amount,
      enabled: true,
      filterJson: filterJson || null,
    },
  });
}

async function createActiveSubscription(strapi, userId, planId, prefix) {
  return await strapi.entityService.create('api::subscription.subscription', {
    data: {
      strapiUserId: userId,
      status: 'active',
      startDate: new Date().toISOString(),
      originalTransactionId: `${prefix}-orig-tx`,
      latestTransactionId: `${prefix}-latest-tx`,
      plan: planId,
    },
  });
}

async function cleanupFixtures(strapi, prefix, userId) {
  const eventIds = await strapi.entityService.findMany('api::usage-event.usage-event', {
    filters: { eventId: { $contains: prefix } },
    fields: ['id'],
  });
  for (const event of eventIds) {
    await strapi.entityService.delete('api::usage-event.usage-event', event.id);
  }

  const usageRecords = await strapi.entityService.findMany('api::usage-record.usage-record', {
    filters: { strapiUserId: userId },
    fields: ['id'],
  });
  for (const record of usageRecords) {
    await strapi.entityService.delete('api::usage-record.usage-record', record.id);
  }

  const usageLedgers = await strapi.entityService.findMany('api::usageledger.usageledger', {
    filters: { strapiUserId: userId },
    fields: ['id'],
  });
  for (const ledger of usageLedgers) {
    await strapi.entityService.delete('api::usageledger.usageledger', ledger.id);
  }

  const subscriptions = await strapi.entityService.findMany('api::subscription.subscription', {
    filters: { strapiUserId: userId },
    fields: ['id'],
  });
  for (const subscription of subscriptions) {
    await strapi.entityService.delete('api::subscription.subscription', subscription.id);
  }

  const rules = await strapi.entityService.findMany('api::usage-rule.usage-rule', {
    filters: { eventName: { $contains: prefix } },
    fields: ['id'],
  });
  for (const rule of rules) {
    await strapi.entityService.delete('api::usage-rule.usage-rule', rule.id);
  }

  const entitlements = await strapi.entityService.findMany('api::entitlement.entitlement', {
    filters: { name: { $contains: prefix } },
    fields: ['id'],
  });
  for (const entitlement of entitlements) {
    await strapi.entityService.delete('api::entitlement.entitlement', entitlement.id);
  }

  const planEntLinks = await strapi.entityService.findMany('api::plan-ent-link.plan-ent-link', {
    populate: { plan: true },
    fields: ['id'],
  });
  for (const link of planEntLinks) {
    if (link.plan?.productId === `${prefix}.product`) {
      await strapi.entityService.delete('api::plan-ent-link.plan-ent-link', link.id);
    }
  }

  const plans = await strapi.entityService.findMany('api::plan.plan', {
    filters: { productId: `${prefix}.product` },
    fields: ['id'],
  });
  for (const plan of plans) {
    await strapi.entityService.delete('api::plan.plan', plan.id);
  }
}

async function run() {
  const strapi = createStrapi();
  const prefix = createTestPrefix();
  const userId = 880000 + Math.floor(Math.random() * 1000);

  await strapi.load();

  try {
    await cleanupFixtures(strapi, prefix, userId);

    const plan = await createPlanFixture(strapi, prefix);
    const aiRequests = await createEntitlementFixture(strapi, prefix, 'ai-requests', 100);
    const ttsRequests = await createEntitlementFixture(strapi, prefix, 'tts-requests', 100);
    const exportJobs = await createEntitlementFixture(strapi, prefix, 'export-jobs', 100);

    await linkPlanEntitlement(strapi, plan.id, aiRequests.id, 100);
    await linkPlanEntitlement(strapi, plan.id, ttsRequests.id, 100);
    await linkPlanEntitlement(strapi, plan.id, exportJobs.id, 100);

    await createUsageRule(strapi, `${prefix}.lesson.generated`, aiRequests.id, 1);
    await createUsageRule(strapi, `${prefix}.lesson.refined`, aiRequests.id, 2);
    await createUsageRule(strapi, `${prefix}.tts.generated`, ttsRequests.id, 5, { provider: 'azure' });
    await createUsageRule(strapi, `${prefix}.asset.exported`, exportJobs.id, 1);
    await createUsageRule(strapi, `${prefix}.asset.exported`, aiRequests.id, 1);

    await createActiveSubscription(strapi, userId, plan.id, prefix);

    await refreshUsageRuleCache(strapi);
    await syncUsageRuleSubscriptions(strapi);

    const usageService = strapi.service('api::usage-record.usage-record');

    const cases = [
      {
        name: 'case 1: lesson.generated increments ai_requests by 1',
        topic: `${prefix}.lesson.generated`,
        payload: { eventId: `${prefix}-evt-1`, userId, username: 'usage-test', source: 'tests' },
        verify: async () => {
          const usage = await usageService.getUsageForUser(userId, aiRequests.slug);
          assert.equal(usage.used, 1);
        },
      },
      {
        name: 'case 2: lesson.refined upserts same usage_record to 3',
        topic: `${prefix}.lesson.refined`,
        payload: { eventId: `${prefix}-evt-2`, userId, username: 'usage-test', source: 'tests' },
        verify: async () => {
          const usage = await usageService.getUsageForUser(userId, aiRequests.slug);
          assert.equal(usage.used, 3);
        },
      },
      {
        name: 'case 3: filtered tts.generated increments tts_requests by 5',
        topic: `${prefix}.tts.generated`,
        payload: { eventId: `${prefix}-evt-3`, userId, username: 'usage-test', provider: 'azure' },
        verify: async () => {
          const usage = await usageService.getUsageForUser(userId, ttsRequests.slug);
          assert.equal(usage.used, 5);
        },
      },
      {
        name: 'case 4: asset.exported applies two rules in one event',
        topic: `${prefix}.asset.exported`,
        payload: { eventId: `${prefix}-evt-4`, userId, username: 'usage-test', assetType: 'pdf' },
        verify: async () => {
          const aiUsage = await usageService.getUsageForUser(userId, aiRequests.slug);
          const exportUsage = await usageService.getUsageForUser(userId, exportJobs.slug);
          assert.equal(aiUsage.used, 4);
          assert.equal(exportUsage.used, 1);
        },
      },
    ];

    for (const testCase of cases) {
      await publishUsageEvent(testCase.topic, testCase.payload);
      await waitFor(async () => {
        try {
          await testCase.verify();
          return true;
        } catch (error) {
          return false;
        }
      }, `Timed out waiting for ${testCase.name}`);
      console.log(`PASS ${testCase.name}`);
    }

    const processedEvents = await strapi.entityService.findMany('api::usage-event.usage-event', {
      filters: { eventId: { $contains: `${prefix}-evt-` } },
      sort: { eventId: 'asc' },
    });
    assert.equal(processedEvents.length, 4);
    assert.ok(processedEvents.every((event) => event.status === 'processed'));

    const usageList = await usageService.getUsageForUser(userId);
    console.log('Final usage snapshot:', JSON.stringify(usageList, null, 2));
  } finally {
    await cleanupFixtures(strapi, prefix, userId);
    await strapi.destroy();
  }
}

run().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
