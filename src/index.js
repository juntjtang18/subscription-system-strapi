'use strict';

module.exports = {
  /**
   * An asynchronous register function that runs before
   * your application is initialized.
   */
  register(/*{ strapi }*/) {},

  /**
   * An asynchronous bootstrap function that runs before
   * your application gets started. This is the correct place
   * to register cron jobs.
   */
  bootstrap({ strapi }) {
    // Moved the require statement here to ensure Strapi is fully loaded first.
    const { doubleCheckAppleReceipts } = require('./utils/cron-jobs');

    // Add the cron job to the Strapi schedule
    strapi.cron.add({
      // Run every hour at the 5-minute mark (e.g., 1:05, 2:05)
      '0 * * * *': async () => {
        // The strapi instance is passed to the job function
        await doubleCheckAppleReceipts(strapi);
      },
    });

    console.log('📅 Apple receipt verification job registered successfully.');
  },
};