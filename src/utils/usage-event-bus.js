'use strict';

const { createEventBus } = require('@langgo/event-bus-client');
const logger = require('./logger');
const usageRuleCache = require('./usage-rule-cache');

let eventBus = null;
let subscriptions = new Map();
let initPromise = null;

function isUsageEventBusEnabled() {
  return process.env.USAGE_EVENT_BUS_ENABLED !== 'false';
}

function encodeConnectionPart(value) {
  return encodeURIComponent(value || '');
}

function buildPostgresConnectionString(env = process.env) {
  if (env.EVENT_BUS_POSTGRES_URL) {
    return env.EVENT_BUS_POSTGRES_URL;
  }

  if (env.DATABASE_URL) {
    return env.DATABASE_URL;
  }

  const user = encodeConnectionPart(env.DATABASE_USERNAME || 'strapi');
  const password = encodeConnectionPart(env.DATABASE_PASSWORD || 'strapi');
  const database = encodeConnectionPart(env.DATABASE_NAME || 'strapi');
  const host = env.DATABASE_HOST || 'localhost';
  const port = env.DATABASE_PORT || '5432';

  if (host.startsWith('/')) {
    return `postgresql://${user}:${password}@/${database}?host=${encodeConnectionPart(host)}&port=${encodeConnectionPart(port)}`;
  }

  return `postgresql://${user}:${password}@${host}:${port}/${database}`;
}

function buildUsageEventBusOptions(env = process.env) {
  const driver = env.EVENT_BUS_DRIVER || 'postgres';

  if (driver === 'postgres') {
    return {
      driver,
      postgres: {
        connectionString: buildPostgresConnectionString(env),
        channelPrefix: env.EVENT_BUS_CHANNEL_PREFIX || 'event_bus',
      },
    };
  }

  if (driver === 'rabbitmq') {
    return {
      driver,
      rabbitmq: {
        url: env.EVENT_BUS_RABBITMQ_URL,
        exchange: env.EVENT_BUS_RABBITMQ_EXCHANGE || 'event_bus',
        exchangeType: env.EVENT_BUS_RABBITMQ_EXCHANGE_TYPE || 'topic',
        queuePrefix: env.EVENT_BUS_QUEUE_PREFIX || 'langgo_subsys_usage',
        durable: env.EVENT_BUS_RABBITMQ_DURABLE !== 'false',
        prefetch: Number(env.EVENT_BUS_RABBITMQ_PREFETCH || 1),
        messagePersistent: env.EVENT_BUS_RABBITMQ_PERSISTENT !== 'false',
      },
    };
  }

  if (driver === 'google-pubsub') {
    return {
      driver,
      google: {
        projectId: env.GCP_PROJECT_ID,
        topicPrefix: env.EVENT_BUS_TOPIC_PREFIX,
        subscriptionPrefix: env.EVENT_BUS_SUBSCRIPTION_PREFIX || 'langgo-subsys-usage',
      },
    };
  }

  throw new Error(`Unsupported EVENT_BUS_DRIVER: ${driver}`);
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
      eventBus = createEventBus(buildUsageEventBusOptions(process.env));
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
  buildPostgresConnectionString,
  buildUsageEventBusOptions,
  initUsageEventBus,
  syncUsageRuleSubscriptions,
  shutdownUsageEventBus,
};
