'use strict';

const { createEventBusFromEnv } = require('@langgo/event-bus-client');

function createUsageEventBusTestClient() {
  return createEventBusFromEnv();
}

async function publishUsageEvent(topic, payload) {
  const client = createUsageEventBusTestClient();

  try {
    return await client.publish(topic, payload);
  } finally {
    await client.close();
  }
}

module.exports = {
  createUsageEventBusTestClient,
  publishUsageEvent,
};
