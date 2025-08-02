module.exports = [
  'strapi::errors',
  'strapi::security',
  {
    name: 'strapi::cors',
    config: {
      origin: [
        'http://localhost:8080',
        'http://localhost:8081',
        'http://192.168.1.66:8080',
        'https://langgo-en-strapi.geniusparentingai.ca',
        'https://langgo-subsys.geniusparentingai.ca',
	      'http://localhost:2338',
        'http://localhost:1338',
      ],
      methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
      headers: '*',
      credentials: true,
    },
  },

  'strapi::poweredBy',
  'strapi::logger',
  'strapi::query',
  'strapi::body',
  'strapi::session',
  'strapi::favicon',
  'strapi::public',
];
