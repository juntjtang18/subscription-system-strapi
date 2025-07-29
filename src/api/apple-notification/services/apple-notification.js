"use strict";

const { AppStoreServerAPI } = require("@apple/app-store-server-library");
const {
  APPLE_APP_BUNDLE_ID,
  APPLE_APP_STORE_ISSUER_ID,
  APPLE_APP_STORE_KEY_ID,
  APPLE_APP_STORE_PRIVATE_KEY,
} = process.env;
const logger = require("../../../utils/logger");
const auditLog = require("../../../utils/audit-log");
const notificationHandlers = require("../../../utils/apple-notification-handlers");

module.exports = ({ strapi }) => ({
  /**
   * Main processing function for all incoming Apple notifications.
   */
  async processNotification(body) {
    const api = new AppStoreServerAPI(
      APPLE_APP_STORE_PRIVATE_KEY,
      APPLE_APP_STORE_KEY_ID,
      APPLE_APP_STORE_ISSUER_ID,
      APPLE_APP_BUNDLE_ID
    );

    let notificationDetails = {
      uuid: null,
      type: null,
      subtype: null,
      originalTransactionId: null,
    };

    try {
      const verificationResult = await api.verifyAndDecodeNotification(
        body.signedPayload
      );
      const jwsPayload = verificationResult;

      notificationDetails.uuid = jwsPayload.notificationUUID;
      notificationDetails.type = jwsPayload.notificationType;
      notificationDetails.subtype = jwsPayload.subtype;

      const transactionInfo = await api.decodeTransaction(
        jwsPayload.data.signedTransactionInfo
      );
      notificationDetails.originalTransactionId =
        transactionInfo.originalTransactionId;

      logger.info(
        `[Apple Webhook SVC] Routing notification: ${notificationDetails.type}`
      );

      const subscription = await strapi.db
        .query("api::subscription.subscription")
        .findOne({
          where: {
            originalTransactionId: transactionInfo.originalTransactionId,
          },
        });

      // Find the correct handler based on the notification type
      const handler = notificationHandlers[notificationDetails.type];

      if (handler) {
        // Call the handler with all the necessary context
        await handler({
          strapi,
          subscription,
          transactionInfo,
          notificationDetails,
        });
      } else {
        // If no handler exists, log it as a warning
        logger.warn(
          `[Apple Webhook SVC] No handler found for notification type: ${notificationDetails.type}`
        );
        await auditLog({ strapi }).record({
          event: "UNHANDLED_NOTIFICATION_TYPE",
          status: "WARNING",
          message: `Received notification type '${notificationDetails.type}' for which no handler is defined.`,
          strapiUserId: subscription ? subscription.strapiUserId : null,
          details: notificationDetails,
        });
      }
    } catch (error) {
      // The entire catch block remains the same as before
      let failureReason = error.message;
      let eventType = "APPLE_NOTIFICATION_FAILURE";

      if (
        !failureReason.includes("data inconsistency") &&
        !failureReason.includes("appAccountToken")
      ) {
        if (error.message.includes("JWS")) {
          failureReason =
            "The notification payload from Apple could not be verified.";
          eventType = "APPLE_NOTIFICATION_VERIFICATION_FAILURE";
        } else {
          failureReason = "An unexpected error occurred during processing.";
        }

        logger.error(`[Apple Webhook SVC] ${failureReason}`, {
          error: error.message,
          details: notificationDetails,
        });

        const subForErrorLog = await strapi.db
          .query("api::subscription.subscription")
          .findOne({
            where: {
              originalTransactionId: notificationDetails.originalTransactionId,
            },
          });

        await auditLog({ strapi }).record({
          event: eventType,
          status: "FAILURE",
          message: `${
            failureReason
          } The notification type was '${notificationDetails.type || "Unknown"}'.`,
          strapiUserId: subForErrorLog ? subForErrorLog.strapiUserId : null,
          details: {
            ...notificationDetails,
            errorMessage: error.message,
          },
        });
      }

      throw error;
    }
  },
});