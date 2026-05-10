'use strict';

const { createEventBus } = require('@langgo/event-bus-client');
const { buildUsageEventBusOptions } = require('../src/utils/usage-event-bus');

function createUsageEventBusTestClient() {
  return createEventBus(buildUsageEventBusOptions(process.env));
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
