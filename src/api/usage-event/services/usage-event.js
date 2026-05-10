'use strict';

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::usage-event.usage-event');
