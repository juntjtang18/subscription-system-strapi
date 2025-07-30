"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'REVOKE' notifications.
 * This is a critical event that requires revoking service immediately.
 * This is functionally similar to a REFUND.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object|null} context.subscription - The existing subscription from the DB.
 * @param {object} context.transactionInfo - Decoded transaction info from Apple.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 * @param {string} context.notificationId
 */
module.exports = async ({
  strapi,
  subscription,
  transactionInfo,
  notificationDetails,
  notificationId,
}) => {
  if (!subscription) {
    const message = `Received a 'REVOKE' notification, but the corresponding subscription does not exist. This is a critical data inconsistency.`;
    logger.error(
      `[Apple REVOKE Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
      event: "REVOKE_FAILURE_SUB_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: null,
      apple_notification: notificationId,
    });
    throw new Error(message);
  }

  // A revocation is a terminal event. Revoke access immediately.
  const { revocationDate, revocationReason } = transactionInfo;

  logger.warn(
    `Processing REVOKE for user ${subscription.strapiUserId}. Revoking access.`
  );

  await strapi.entityService.update(
    "api::subscription.subscription",
    subscription.id,
    {
      data: {
        status: "revoked",
        revocationDate: revocationDate ? new Date(revocationDate) : new Date(),
        // Apple provides a reason code, we store it for reference.
        revocationReason: `REVOKE_REASON_${revocationReason || "UNKNOWN"}`,
      },
    }
  );

  await auditLog({ strapi }).record({
    event: "USER_SUBSCRIPTION_REVOKED",
    status: "WARNING", // A revocation is a negative business event.
    message: `Subscription was revoked by Apple and access has been removed.`,
    strapiUserId: subscription.strapiUserId,
    details: notificationDetails,
    apple_notification: notificationId,
  
  });
};