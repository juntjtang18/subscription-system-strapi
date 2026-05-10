'use strict';

const logger = require('./logger');

let initialized = false;
let rulesByEventName = new Map();

function groupRulesByEventName(rules) {
  const grouped = new Map();

  for (const rule of rules) {
    if (!rule?.enabled || !rule?.eventName || !rule?.entitlement) {
      continue;
    }

    if (!grouped.has(rule.eventName)) {
      grouped.set(rule.eventName, []);
    }

    grouped.get(rule.eventName).push(rule);
  }

  return grouped;
}

async function refreshUsageRuleCache(strapi) {
  const rules = await strapi.entityService.findMany('api::usage-rule.usage-rule', {
    filters: { enabled: true },
    populate: { entitlement: true },
    sort: [{ eventName: 'asc' }, { id: 'asc' }],
  });

  rulesByEventName = groupRulesByEventName(rules);
  initialized = true;

  logger.info(
    `[usage-rule-cache] Loaded ${rules.length} enabled rules across ${rulesByEventName.size} event topic(s).`
  );

  return getCacheSnapshot();
}

function getRulesForEvent(eventName) {
  if (!initialized) {
    return null;
  }

  return rulesByEventName.get(eventName) || [];
}

function getSubscribedEventNames() {
  if (!initialized) {
    return [];
  }

  return Array.from(rulesByEventName.keys()).sort();
}

function getCacheSnapshot() {
  return {
    initialized,
    eventNames: getSubscribedEventNames(),
    rulesByEventName,
  };
}

module.exports = {
  refreshUsageRuleCache,
  getRulesForEvent,
  getSubscribedEventNames,
  getCacheSnapshot,
};
