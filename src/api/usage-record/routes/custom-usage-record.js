'use strict';

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/v1/internal/usage/events',
      handler: 'usage-record.ingestEvent',
      config: { policies: [], middlewares: [] },
    },
    {
      method: 'GET',
      path: '/v1/internal/usage',
      handler: 'usage-record.getUsage',
      config: { policies: [], middlewares: [] },
    },
    {
      method: 'GET',
      path: '/v1/internal/usage/:metric',
      handler: 'usage-record.getUsageByMetric',
      config: { policies: [], middlewares: [] },
    },
  ],
};
