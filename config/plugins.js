module.exports = {
    'documentation': {
      enabled: true,
      config: {
        openapi: '3.0.0',
        info: {
          version: '1.0.0',
          title: 'Subscription Subsystem API',
          description: 'API for managing user subscriptions and payments.',
        },
        // This makes the documentation page public.
        // Set to true if you need to protect it behind a login.
        'x-strapi-config': {
          auth: false,
        },
      },
    },
  };