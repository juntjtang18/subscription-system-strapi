"use strict";

const fs = require("fs");
const path = require("path");

// CORRECTED: Import all necessary classes from the library
const {
  AppStoreServerAPIClient,
  SignedDataVerifier,
  Environment,
} = require("@apple/app-store-server-library");

const {
  APPLE_APP_BUNDLE_ID,
  APPLE_APP_STORE_ISSUER_ID,
  APPLE_APP_STORE_KEY_ID,
  APPLE_APP_STORE_PRIVATE_KEY,
} = process.env;
const logger = require("../../../utils/logger");
const auditLog = require("../../../utils/audit-log");
const notificationHandlers = require("../../../utils/apple-notification-handlers");

// Helper function to load the Apple Root CA certificate from your project files
const loadAppleRootCAs = () => {
  try {
    // IMPORTANT: Make sure this path is correct for your project structure.
    const certPath = path.resolve(
      process.cwd(),
      "src/config/certs/AppleRootCA-G3.cer"
    );
    return [fs.readFileSync(certPath)];
  } catch (error) {
    logger.error(
      "FATAL: Could not load Apple Root CA certificate. Please ensure 'src/config/certs/AppleRootCA-G3.cer' exists.",
      error
    );
    // Stop the process if the cert can't be loaded, as verification is impossible.
    process.exit(1);
  }
};

const appleRootCAs = loadAppleRootCAs();

module.exports = ({ strapi }) => ({
  /**
   * Main processing function for all incoming Apple notifications.
   */
  async processNotification(body) {
    // IMPORTANT: Change Environment.SANDBOX to Environment.PRODUCTION when you go live.
    const environment = Environment.SANDBOX;

    // The verifier is now a separate class for decoding and verifying payloads.
    const verifier = new SignedDataVerifier(
      appleRootCAs,
      true, // enable online checks
      environment,
      APPLE_APP_BUNDLE_ID
    );
    
    // The client is used for making other API calls (not needed in this function but good practice to have)
    const client = new AppStoreServerAPIClient(
        APPLE_APP_STORE_PRIVATE_KEY,
        APPLE_APP_STORE_KEY_ID,
        APPLE_APP_STORE_ISSUER_ID,
        APPLE_APP_BUNDLE_ID,
        environment
      );

    let notificationDetails = {
      uuid: null,
      type: null,
      subtype: null,
      originalTransactionId: null,
    };

    try {
      // CORRECTED: Use the verifier instance to decode the notification
      const jwsPayload = await verifier.verifyAndDecodeNotification(
        body.signedPayload
      );

      notificationDetails.uuid = jwsPayload.notificationUUID;
      notificationDetails.type = jwsPayload.notificationType;
      notificationDetails.subtype = jwsPayload.subtype;

      // CORRECTED: Use the verifier instance to decode the transaction info
      const transactionInfo = await verifier.verifyAndDecodeTransaction(
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

      const handler = notificationHandlers[notificationDetails.type];

      if (handler) {
        await handler({
          strapi,
          subscription,
          transactionInfo,
          notificationDetails,
        });
      } else {
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
      // The catch block remains correct.
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