'use strict';

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/v1/all-plans',
      handler: 'plan.findAllWithDetails',
      config: {
        policies: [],
        middlewares: [],
      },
    },
    // --- ADD THIS NEW ROUTE OBJECT ---
    {
      method: 'GET',
      path: '/v1/plans/:id', // The new endpoint for a single plan
      handler: 'plan.findOneWithDetails',
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};