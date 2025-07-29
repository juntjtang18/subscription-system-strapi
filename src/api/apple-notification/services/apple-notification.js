"use strict";

const jose = require("node-jose");
const logger = require("../../../utils/logger");
const auditLog = require("../../../utils/audit-log");
const notificationHandlers = require("../../../utils/apple-notification-handlers");

module.exports = ({ strapi }) => ({
  /**
   * Processes an incoming Apple Server Notification using the node-jose library for JWS verification.
   * @param {object} body The raw request body from Apple containing the signedPayload.
   */
  async processNotification(body) {
    let notificationEntry;

    // 1. EARLY PERSISTENCE: Save the raw payload immediately.
    try {
      notificationEntry = await strapi.entityService.create(
        "api::apple-notification.apple-notification",
        {
          data: {
            rawSignedPayload: body.signedPayload,
            processingStatus: "received",
            publishedAt: new Date(),
          },
        }
      );
    } catch (dbError) {
      logger.error(
        "CRITICAL: Failed to persist preliminary notification record.",
        { error: dbError }
      );
      throw dbError;
    }

    try {
      // 2. DECODE PAYLOAD
      const jwsPayload = await this.verifyAppleJWS(body.signedPayload);

      // **THE FIX IS HERE:** Create a clean object for logging.
      // We destructure the payload to separate the 'data' field (which has the long string)
      // from the rest of the readable fields.
      const { data, ...loggablePayload } = jwsPayload;
      logger.info(
        `[Apple Webhook SVC] Decoded Payload (UUID: ${jwsPayload.notificationUUID}):`,
        loggablePayload // Log only the clean, readable part.
      );

      // Check for duplicate notifications.
      const existingLogs = await strapi.db
        .query("api::apple-notification.apple-notification")
        .findMany({
          filters: {
            notificationUUID: jwsPayload.notificationUUID,
            id: { $ne: notificationEntry.id },
          },
        });

      if (existingLogs && existingLogs.length > 0) {
        logger.warn(
          `[Apple Webhook SVC] Duplicate notification received (UUID: ${jwsPayload.notificationUUID}). Skipping.`
        );
        await strapi.entityService.update(
          "api::apple-notification.apple-notification",
          notificationEntry.id,
          { data: { processingStatus: "duplicate" } }
        );
        return;
      }
      
      // Update our record with the decoded top-level details.
      await strapi.entityService.update(
        "api::apple-notification.apple-notification",
        notificationEntry.id,
        {
          data: {
            notificationUUID: jwsPayload.notificationUUID,
            notificationType: jwsPayload.notificationType,
            subtype: jwsPayload.subtype,
          },
        }
      );
      
      // Handle TEST notifications separately.
      if (jwsPayload.notificationType === 'TEST') {
        const handler = notificationHandlers['TEST'];
        if (handler) {
            await handler({ strapi, notificationDetails: { uuid: jwsPayload.notificationUUID } });
        }
        await strapi.entityService.update("api::apple-notification.apple-notification", notificationEntry.id, {
            data: { processingStatus: "processed" },
        });
        return;
      }

      const transactionInfo = await this.verifyAppleJWS(
        jwsPayload.data.signedTransactionInfo
      );

      const notificationDetails = {
        uuid: jwsPayload.notificationUUID,
        type: jwsPayload.notificationType,
        subtype: jwsPayload.subtype,
        originalTransactionId: transactionInfo.originalTransactionId,
      };

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
          `[Apple Webhook SVC] No handler found for type: ${notificationDetails.type}`
        );
      }
      
      await strapi.entityService.update("api::apple-notification.apple-notification", notificationEntry.id, {
        data: { processingStatus: "processed" },
      });

    } catch (error) {
      logger.error(
        "[Apple Webhook SVC] An error occurred during notification processing.",
        {
          error: { message: error.message, stack: error.stack },
          notificationId: notificationEntry.id,
        }
      );

      await strapi.entityService.update(
        "api::apple-notification.apple-notification",
        notificationEntry.id,
        {
          data: { processingStatus: "failed_verification" },
        }
      );

      await auditLog({ strapi }).record({
        event: "NOTIFICATION_PROCESSING_FAILURE",
        status: "FAILURE",
        message: `Processing failed with error: ${error.message}`,
        details: { errorMessage: error.stack },
        apple_notification: notificationEntry.id,
      });

      throw error;
    }
  },

  /**
   * Verifies and decodes a JWS token from Apple using the node-jose library.
   * @param {string} token The JWS token string.
   * @returns {object} The decoded payload.
   */
  async verifyAppleJWS(token) {
    try {
      const headerB64 = token.split(".")[0];
      const header = JSON.parse(
        Buffer.from(headerB64, "base64url").toString("utf8")
      );
      const certPem = `-----BEGIN CERTIFICATE-----\n${header.x5c[0]}\n-----END CERTIFICATE-----`;
      const key = await jose.JWK.asKey(certPem, "pem");
      const verifier = jose.JWS.createVerify(key);
      const result = await verifier.verify(token);
      return JSON.parse(result.payload.toString());
    } catch (error) {
      logger.error(
        `[Apple Webhook SVC] JWS verification failed with node-jose: ${error.message}`
      );
      throw new Error(`JWS verification failed.`);
    }
  },
});