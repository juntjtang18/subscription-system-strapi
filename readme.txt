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

// ./src/api/subscription/routes/01-custom-subscription.js

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/subscriptions/subscribe-free-plan',
      handler: 'subscription.subscribeFreePlan',
      config: {
        policies: [],
        middlewares: [],
      },
    },
    {
      method: 'POST',
      path: '/subscriptions/subscribe-to-plan',
      handler: 'subscription.subscribeToPlan',
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};

