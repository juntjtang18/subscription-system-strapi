"use strict";

const { AppStoreServerAPI } = require("@apple/app-store-server-library");
const {
  APPLE_APP_BUNDLE_ID,
  APPLE_APP_STORE_ISSUER_ID,
  APPLE_APP_STORE_KEY_ID,
  APPLE_APP_STORE_PRIVATE_KEY,
} = process.env;
const logger = require("../../../utils/logger"); // Your technical logger for developers
const auditLog = require("../../../utils/audit-log"); // The business logger for admins

module.exports = ({ strapi }) => ({
  /**
   * Processes the incoming Apple notification with robust business audit logging.
   * @param {object} body The request body containing the signed payload.
   */
  async processNotification(body) {
    const api = new AppStoreServerAPI(
      APPLE_APP_STORE_PRIVATE_KEY,
      APPLE_APP_STORE_KEY_ID,
      APPLE_APP_STORE_ISSUER_ID,
      APPLE_APP_BUNDLE_ID
    );

    // Object to hold key identifiers for reliable logging
    let notificationDetails = {
      uuid: null,
      type: null,
      subtype: null,
      originalTransactionId: null,
    };

    try {
      // 1. Verify and Decode the Payload from Apple
      const verificationResult = await api.verifyAndDecodeNotification(
        body.signedPayload
      );
      const jwsPayload = verificationResult;

      // 2. Immediately Extract Key Information for Logging
      notificationDetails.uuid = jwsPayload.notificationUUID;
      notificationDetails.type = jwsPayload.notificationType;
      notificationDetails.subtype = jwsPayload.subtype;

      const transactionInfo = await api.decodeTransaction(
        jwsPayload.data.signedTransactionInfo
      );
      notificationDetails.originalTransactionId =
        transactionInfo.originalTransactionId;

      logger.info(
        `[Apple Webhook SVC] Processing notification: ${notificationDetails.type} (${notificationDetails.subtype || 'N/A'}) - UUID: ${notificationDetails.uuid}`
      );

      // 3. Find the Subscription using the transaction ID
      const subscription = await strapi.db
        .query("api::subscription.subscription")
        .findOne({
          where: {
            originalTransactionId: transactionInfo.originalTransactionId,
          },
        });

      // 4. Handle FATAL ERROR: Subscription Not Found in subsys
      if (!subscription) {
        const message = `A valid '${notificationDetails.type}' notification was received from Apple, but the corresponding subscription does not exist in the local database. This is a critical data inconsistency.`;

        // **Log as a FATAL error for the admin**
        await auditLog({ strapi }).record({
          event: "SUBSCRIPTION_MISSING_FOR_NOTIFICATION",
          status: "FAILURE",
          message: message,
          details: notificationDetails, // Log all known details for investigation
          strapiUserId: null, // No user ID is available
        });
        
        logger.error(`[Apple Webhook SVC] FATAL: ${message} - UUID: ${notificationDetails.uuid}`);
        throw new Error(message);
      }

      // 5. Normal Processing Logic
      // ... Your existing logic to update subscription status goes here ...
      // For example:
      // await strapi.service('api::subscription.subscription').handleStateChange(subscription, transactionInfo);
      
      logger.info(
        `[Apple Webhook SVC] Successfully processed notification for strapiUserId: ${subscription.strapiUserId}`
      );

    } catch (error) {
      // 6. Catch-All Failure Handling
      let failureReason = error.message;
      let eventType = "APPLE_NOTIFICATION_FAILURE";

      if (!failureReason.includes("data inconsistency")) {
        if (error.message.includes("JWS")) {
            failureReason = "The notification payload from Apple could not be verified.";
            eventType = "APPLE_NOTIFICATION_VERIFICATION_FAILURE";
        } else {
            failureReason = "An unexpected error occurred during processing.";
        }
        
        logger.error(`[Apple Webhook SVC] ${failureReason}`, {
            error: error.message,
            details: notificationDetails,
        });

        // Attempt to find subscription to log the associated user ID
        const subForErrorLog = await strapi.db.query("api::subscription.subscription").findOne({
            where: { originalTransactionId: notificationDetails.originalTransactionId },
        });

        await auditLog({ strapi }).record({
            event: eventType,
            status: "FAILURE",
            message: `${failureReason} The notification type was '${notificationDetails.type || "Unknown"}'.`,
            // **Use the correct field name from your schema**
            strapiUserId: subForErrorLog ? subForErrorLog.strapiUserId : null,
            details: {
                ...notificationDetails,
                errorMessage: error.message,
            },
        });
      }

      // Rethrow the error to ensure Apple's server retries the notification
      throw error;
    }
  },
});