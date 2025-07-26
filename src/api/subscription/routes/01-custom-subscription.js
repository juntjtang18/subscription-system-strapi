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
        // Add this documentation block
        info: {
          summary: 'Verify an Apple In-App Purchase',
          description: 'Validates an Apple receipt, and creates or updates a user subscription.',
          tags: ['Subscription'],
        },
        // Describe the request body
        body: {
          schema: {
            type: 'object',
            properties: {
              userId: { type: 'integer', example: 123 },
              receipt: { type: 'string', example: 'fakeheader.eyJ...fakesignature' }
            },
            required: ['userId', 'receipt']
          }
        },
        // Describe the success response
        responses: {
          '200': {
            description: 'Successful verification. Returns the updated subscription object.',
            content: {
              'application/json': {
                schema: {
                  $ref: '#/components/schemas/SubscriptionResponse' // This references the standard Strapi response schema
                }
              }
            }
          },
          '400': { description: 'Bad Request (e.g., missing fields, invalid receipt)' },
          '500': { description: 'Internal Server Error' }
        },
      },
    },    
  ],
};