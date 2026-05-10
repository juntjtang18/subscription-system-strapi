'use strict';

const { refreshUsageRuleCache } = require('../../../../utils/usage-rule-cache');
const { syncUsageRuleSubscriptions } = require('../../../../utils/usage-event-bus');

async function refreshAndSync() {
  const strapi = global.strapi;
  if (!strapi) {
    return;
  }

  await refreshUsageRuleCache(strapi);
  await syncUsageRuleSubscriptions(strapi);
}

module.exports = {
  async afterCreate() {
    await refreshAndSync();
  },

  async afterUpdate() {
    await refreshAndSync();
  },

  async afterDelete() {
    await refreshAndSync();
  },
};
