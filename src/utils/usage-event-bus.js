'use strict';

const { createEventBusFromEnv } = require('@langgo/event-bus-client');
const logger = require('./logger');
const usageRuleCache = require('./usage-rule-cache');

let eventBus = null;
let subscriptions = new Map();
let initPromise = null;

function isUsageEventBusEnabled() {
  return process.env.USAGE_EVENT_BUS_ENABLED !== 'false';
}

async function subscribeToTopic(strapi, topic) {
  if (!eventBus || subscriptions.has(topic)) {
    return;
  }

  const consumerName = process.env.EVENT_BUS_CONSUMER_NAME || 'langgo_subsys_usage_meter';
  const handle = await eventBus.subscribe(
    topic,
    async (message) => {
      try {
        await strapi.service('api::usage-record.usage-record').processEventFromBus({
          topic,
          payload: message.payload,
          publishedAt: message.publishedAt,
        });
        await message.ack();
      } catch (error) {
        logger.error(`[usage-event-bus] Failed to process topic "${topic}": ${error.message}`);
        await message.nack();
      }
    },
    { consumerName }
  );

  subscriptions.set(topic, handle);
  logger.info(`[usage-event-bus] Subscribed to topic "${topic}".`);
}

async function syncUsageRuleSubscriptions(strapi) {
  if (!eventBus) {
    return;
  }

  const activeTopics = new Set(usageRuleCache.getSubscribedEventNames());

  for (const [topic, handle] of subscriptions.entries()) {
    if (activeTopics.has(topic)) {
      continue;
    }

    await handle.unsubscribe();
    subscriptions.delete(topic);
    logger.info(`[usage-event-bus] Unsubscribed from topic "${topic}".`);
  }

  for (const topic of activeTopics) {
    await subscribeToTopic(strapi, topic);
  }
}

async function initUsageEventBus(strapi) {
  if (!isUsageEventBusEnabled()) {
    logger.info('[usage-event-bus] Disabled by USAGE_EVENT_BUS_ENABLED=false.');
    return;
  }

  if (initPromise) {
    return initPromise;
  }

  initPromise = (async () => {
    await usageRuleCache.refreshUsageRuleCache(strapi);

    if (!eventBus) {
      eventBus = createEventBusFromEnv();
      logger.info(`[usage-event-bus] Initialized driver "${eventBus.driver}".`);
    }

    await syncUsageRuleSubscriptions(strapi);
  })();

  try {
    await initPromise;
  } finally {
    initPromise = null;
  }
}

async function shutdownUsageEventBus() {
  for (const [topic, handle] of subscriptions.entries()) {
    try {
      await handle.unsubscribe();
      logger.info(`[usage-event-bus] Unsubscribed from topic "${topic}" during shutdown.`);
    } catch (error) {
      logger.warn(`[usage-event-bus] Failed to unsubscribe from "${topic}": ${error.message}`);
    }
  }

  subscriptions = new Map();

  if (eventBus) {
    await eventBus.close();
    logger.info('[usage-event-bus] Event bus closed.');
    eventBus = null;
  }
}

module.exports = {
  initUsageEventBus,
  syncUsageRuleSubscriptions,
  shutdownUsageEventBus,
};
