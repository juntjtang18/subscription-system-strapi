'use strict';

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::usage-rule.usage-rule');
