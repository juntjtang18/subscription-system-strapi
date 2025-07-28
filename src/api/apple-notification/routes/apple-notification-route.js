"use strict";

/**
 * apple-notification router
 */

module.exports = {
  routes: [
    {
      method: "POST",
      path: "/apple-notifications",
      handler: "apple-notification.handle",
      config: {
        auth: false, // This endpoint should be public for Apple's servers
      },
    },
  ],
};