"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'REFUND' notifications.
 * This is a critical event that requires revoking service immediately.
 * The subscription status is set to 'revoked'.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object|null} context.subscription - The existing subscription from the DB.
 * @param {object} context.transactionInfo - Decoded transaction info from Apple.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 */
module.exports = async ({
  strapi,
  subscription,
  transactionInfo,
  notificationDetails,
}) => {
  if (!subscription) {
    const message = `Received a 'REFUND' notification, but the corresponding subscription does not exist. This is a critical data inconsistency.`;
    logger.error(
      `[Apple REFUND Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
      event: "REFUND_FAILURE_SUB_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: null,
    });
    throw new Error(message);
  }

  // A refund is a terminal event. Revoke access immediately.
  const { revocationDate, revocationReason } = transactionInfo;

  logger.warn(
    `Processing REFUND for user ${subscription.strapiUserId}. Revoking access.`
  );

  await strapi.entityService.update(
    "api::subscription.subscription",
    subscription.id,
    {
      data: {
        status: "revoked",
        revocationDate: revocationDate ? new Date(revocationDate) : new Date(),
        // Apple provides a reason code: 0 for developer issue, 1 for other.
        revocationReason: revocationReason === 1 ? "REFUND_OTHER" : "REFUND_DEV_ISSUE",
      },
    }
  );

  await auditLog({ strapi }).record({
    event: "USER_SUBSCRIPTION_REFUNDED",
    status: "WARNING", // A refund is a negative business event, so we use WARNING.
    message: `Subscription was refunded and access has been revoked.`,
    strapiUserId: subscription.strapiUserId,
    details: notificationDetails,
  });
};