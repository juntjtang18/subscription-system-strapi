// ./src/api/subscription/routes/01-custom-subscription.js

module.exports = {
  routes: [
    {
      method: 'POST',
      path: '/v1/subscriptions/subscribe-free-plan',
      handler: 'subscription.subscribeFreePlan',
      config: {
        policies: [],
        middlewares: [],
      },
    },
    {
      method: 'POST',
      path: '/v1/subscriptions/subscribe-to-plan',
      handler: 'subscription.subscribeToPlan',
      config: {
        policies: [],
        middlewares: [],
      },
    },
    {
      method: 'GET',
      path: '/v1/subscription-of-a-user/:userId',
      handler: 'subscription.getSubscriptionForUser',
      config: {
        policies: [],
        middlewares: [],
      },
    },
    {
      method: 'POST',
      path: '/v1/verify-apple-purchase',
      handler: 'subscription.verifyApplePurchase',
      config: {
        policies: [],
        middlewares: [],
      },
    },    
  ],
};