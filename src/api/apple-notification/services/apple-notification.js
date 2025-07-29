"use strict";

const jose = require("node-jose");
const logger = require("../../../utils/logger");
const auditLog = require("../../../utils/audit-log");
const notificationHandlers = require("../../../utils/apple-notification-handlers");

module.exports = ({ strapi }) => ({
  async processNotification(body) {
    let notificationEntry;

    // 1. EARLY PERSISTENCE
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
      // 2. JWS VERIFICATION
      const jwsPayload = await this.verifyAppleJWS(body.signedPayload);
      const { data, ...loggablePayload } = jwsPayload;
      logger.info(
        `[Apple Webhook SVC] Decoded Payload (UUID: ${jwsPayload.notificationUUID}):`,
        loggablePayload
      );

      // check UUID duplication
      const existingLogs = await strapi.entityService.findMany("api::apple-notification.apple-notification", {
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
      
      if (jwsPayload.notificationType === 'TEST') {
        // For TEST notifications, update and process without transaction info
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
        const handler = notificationHandlers['TEST'];
        if (handler) {
            await handler({ strapi, notificationId: notificationEntry.id, notificationDetails: { uuid: jwsPayload.notificationUUID } });
        }
        await strapi.entityService.update("api::apple-notification.apple-notification", notificationEntry.id, {
            data: { processingStatus: "processed" },
        });
        return;
      }

      const transactionInfo = await this.verifyAppleJWS(
        jwsPayload.data.signedTransactionInfo
      );

      // 2. EARLY UPDATE with transactionInfo
      await strapi.entityService.update(
        "api::apple-notification.apple-notification",
        notificationEntry.id,
        {
          data: {
            notificationUUID: jwsPayload.notificationUUID,
            notificationType: jwsPayload.notificationType,
            subtype: jwsPayload.subtype,
            transactionInfo: transactionInfo, // Persist the full decoded transaction info
          },
        }
      );

      const notificationDetails = {
        uuid: jwsPayload.notificationUUID,
        type: jwsPayload.notificationType,
        subtype: jwsPayload.subtype,
        originalTransactionId: transactionInfo.originalTransactionId,
      };
      
      const subscriptions = await strapi.entityService.findMany("api::subscription.subscription", {
          filters: {
            originalTransactionId: transactionInfo.originalTransactionId,
          },
          sort: { createdAt: 'desc' },
        });

      let subscription = subscriptions.find(s => s.status === 'active') || subscriptions[0];

      // --- Debug Logging Start ---
      if (subscription) {
        logger.info(`[Apple Webhook SVC] Found subscription with ID: ${subscription.id} for notification UUID: ${notificationDetails.uuid}`);
      } else {
        logger.warn(`[Apple Webhook SVC] No subscription found for originalTransactionId: ${transactionInfo.originalTransactionId}. A new one may be created by the handler.`);
      }
      // --- Debug Logging End ---

      const handler = notificationHandlers[notificationDetails.type];
      if (handler) {
        await handler({
          strapi,
          subscription,
          transactionInfo,
          notificationDetails,
          notificationId: notificationEntry.id,
        });
      } else {
        logger.warn(
          `[Apple Webhook SVC] No handler found for type: ${notificationDetails.type}`
        );
      }
      
      // --- Change Start ---
      // Final update now includes the subscription relation and originalTransactionId
      await strapi.entityService.update("api::apple-notification.apple-notification", notificationEntry.id, {
        data: { 
          processingStatus: "processed",
          originalTransactionId: transactionInfo.originalTransactionId,
          subscription: subscription ? subscription.id : null,
        },
      });
      // --- Change End ---

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