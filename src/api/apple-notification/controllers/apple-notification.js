"use strict";

/**
 * apple-notification controller
 */

const { createCoreController } = require("@strapi/strapi").factories;
const logger = require("../../../utils/logger");

module.exports = createCoreController("api::apple-notification.apple-notification", ({ strapi }) => ({
    // This is our custom action. The route points to this function.
    async handle(ctx) {
      logger.info("[Apple Webhook CTRL] Received a notification.");

      try {
        // Pass the entire request body to the service for processing
        await strapi
          .service("api::apple-notification.apple-notification")
          .processNotification(ctx.request.body);

        // Acknowledge receipt with a 200 OK status
        ctx.send({ status: "received" }, 200);
      } catch (error) {
        logger.error(
          `[Apple Webhook CTRL] Error processing notification: ${error.message}`
        );
        // Send an appropriate error response. Apple will retry on 5xx errors.
        ctx.send({ error: "Failed to process notification" }, 500);
      }
    },
      // --- Add this new handler for testing ---
    async testEvent(ctx) {
        try {
            const { notificationType, transactionInfo } = ctx.request.body;

            if (!notificationType || !transactionInfo) {
                return ctx.badRequest('Request body must include notificationType and transactionInfo');
            }

            const result = await strapi
                .service('api::apple-notification.apple-notification')
                .processTestEvent({ notificationType, transactionInfo });
            ctx.send(result);
            
        } catch (error) {
            strapi.log.error(`Apple Test Event Error: ${error.message}`);
            return ctx.badRequest(error.message);
        }
    },
}));