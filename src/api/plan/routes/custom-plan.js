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
  ],
};