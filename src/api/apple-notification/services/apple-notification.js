// ./src/api/apple-notification/services/apple-notification.js
"use strict";

const logger = require("../../../utils/logger");
const { verifyAppleJWS } = require("../../../utils/apple-jws-verifier"); // Import the new verifier

module.exports = ({ strapi }) => ({
  async processNotification(requestBody) {
    logger.info(
      `[Apple Webhook SVC] RAW PAYLOAD RECEIVED: ${JSON.stringify(
        requestBody,
        null,
        2
      )}`
    );

    if (!requestBody || !requestBody.signedPayload) {
      throw new Error("Request body or signedPayload is missing.");
    }
    const { signedPayload } = requestBody;

    let logEntry = null;

    try {
      const decodedPayload = await verifyAppleJWS(signedPayload); // Use the verifier

      // ✨ NEW: Log the decoded main payload
      logger.info(
        `[Apple Webhook SVC] Decoded Main Payload: ${JSON.stringify(
          decodedPayload,
          null,
          2
        )}`
      );

      const existingLogs = await strapi.entityService.findMany(
        "api::apple-notification.apple-notification",
        {
          filters: { notificationUUID: decodedPayload.notificationUUID },
        }
      );

      if (existingLogs && existingLogs.length > 0) {
        logger.warn(
          `[Apple Webhook SVC] Duplicate notification received (UUID: ${decodedPayload.notificationUUID}). Skipping.`
        );
        return;
      }

      logEntry = await strapi.entityService.create(
        "api::apple-notification.apple-notification",
        {
          data: {
            rawSignedPayload: signedPayload,
            processingStatus: "received",
            notificationUUID: decodedPayload.notificationUUID,
            notificationType: decodedPayload.notificationType,
            subtype: decodedPayload.subtype,
          },
        }
      );

      if (decodedPayload.notificationType === "TEST") {
        logger.info(
          "[Apple Webhook SVC] TEST notification successfully verified. No transaction data to process."
        );
        await this.updateLogStatus(logEntry.id, "processed");
        return;
      }

      const signedTransactionInfo = decodedPayload.data.signedTransactionInfo;
      const transactionInfo = await verifyAppleJWS(signedTransactionInfo); // Use the verifier

      // ✨ NEW: Log the decoded transaction info
      logger.info(
        `[Apple Webhook SVC] Decoded Transaction Info: ${JSON.stringify(
          transactionInfo,
          null,
          2
        )}`
      );

      await strapi.entityService.update(
        "api::apple-notification.apple-notification",
        logEntry.id,
        {
          data: {
            transactionInfo,
            originalTransactionId: transactionInfo.originalTransactionId,
          },
        }
      );

      const subscriptions = await strapi.entityService.findMany(
        "api::subscription.subscription",
        {
          filters: {
            originalTransactionId: transactionInfo.originalTransactionId,
          },
        }
      );

      if (!subscriptions || subscriptions.length === 0) {
        await this.updateLogStatus(logEntry.id, "failed_not_found");
        throw new Error(
          `No subscription found for originalTransactionId: ${transactionInfo.originalTransactionId}`
        );
      }
      const subscription = subscriptions[0];

      const updates = this.getSubscriptionUpdates(
        decodedPayload.notificationType,
        transactionInfo
      );
      if (Object.keys(updates).length > 1) {
        await strapi.entityService.update(
          "api::subscription.subscription",
          subscription.id,
          { data: updates }
        );
      }

      await this.updateLogStatus(logEntry.id, "processed", subscription.id);
      logger.info(
        `[Apple Webhook SVC] Successfully processed notification for subscription ID: ${subscription.id}`
      );
    } catch (error) {
      if (logEntry && logEntry.id) {
        if (error.message.includes("JWS")) {
          await this.updateLogStatus(logEntry.id, "failed_verification");
        }
      }
      logger.error(
        `[Apple Webhook SVC] Final error in processing: ${error.message}`
      );
      throw error;
    }
  },

  getSubscriptionUpdates(notificationType, transactionInfo) {
    const { transactionId, expiresDate } = transactionInfo;
    const updates = { latestTransactionId: transactionId };
    switch (notificationType) {
      case "DID_RENEW":
      case "SUBSCRIBED":
      case "OFFER_REDEEMED":
        updates.status = "active";
        if (expiresDate) updates.expireDate = new Date(expiresDate);
        break;
      case "EXPIRED":
        updates.status = "expired";
        if (expiresDate) updates.expireDate = new Date(expiresDate);
        break;
      case "REVOKE":
      case "REFUND":
        updates.status = "canceled";
        break;
      default:
        logger.warn(
          `[Apple Webhook SVC] Unhandled notification type: ${notificationType}.`
        );
    }
    return updates;
  },

  async updateLogStatus(logId, status, subscriptionId = null) {
    const data = { processingStatus: status };
    if (subscriptionId) {
      data.subscription = subscriptionId;
    }
    return strapi.entityService.update(
      "api::apple-notification.apple-notification",
      logId,
      { data }
    );
  },
});