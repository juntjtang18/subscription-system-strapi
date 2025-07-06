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
