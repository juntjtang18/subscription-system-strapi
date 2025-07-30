"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'DID_FAIL_TO_RENEW' notifications.
 * This function updates the subscription status to reflect a billing issue,
 * often entering a grace period.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object|null} context.subscription - The existing subscription from the DB.
 * @param {object} context.transactionInfo - Decoded transaction info from Apple.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 * @param {string} context.notificationId - The ID of the saved notification entry for linking.
 */
module.exports = async ({
  strapi,
  subscription,
  transactionInfo,
  notificationDetails,
  notificationId,
}) => {
  // If the subscription doesn't exist for a renewal failure event, it's a critical data issue.
  if (!subscription) {
    const message = `Received a 'DID_FAIL_TO_RENEW' notification, but the corresponding subscription does not exist. This is a critical data inconsistency.`;
    logger.error(
      `[Apple DID_FAIL_TO_RENEW Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
      event: "RENEWAL_FAILURE_SUB_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: null,
      apple_notification: notificationId, // Link the audit log to the notification
    });
    throw new Error(message);
  }

  // --- Primary Path: Update the subscription status based on the subtype ---
  const { productId } = transactionInfo;
  const reason = notificationDetails.subtype || "BILLING_ERROR";
  let newStatus = "billing-issue"; // Default status for a renewal failure
  let auditMessage = `Subscription renewal for plan '${productId}' failed due to a billing error.`;

  // If Apple grants a grace period, we set a specific status for it.
  if (reason === "GRACE_PERIOD") {
    newStatus = "grace-period";
    auditMessage = `Subscription for plan '${productId}' failed to renew and has entered a grace period.`;
    logger.info(
      `User ${subscription.strapiUserId} entered grace period for sub ${subscription.id}.`
    );
  } else {
    logger.warn(
      `User ${subscription.strapiUserId} has a billing issue for sub ${subscription.id}. Reason: ${reason}`
    );
  }

  const updatedSubscription = await strapi.entityService.update(
    "api::subscription.subscription",
    subscription.id,
    {
      data: {
        status: newStatus,
      },
    }
  );

  await auditLog({ strapi }).record({
    event: "USER_SUBSCRIPTION_RENEWAL_FAILED",
    status: "WARNING", // A renewal failure is a warning, not a hard error.
    message: auditMessage,
    strapiUserId: updatedSubscription.strapiUserId,
    details: notificationDetails,
    apple_notification: notificationId, // Link the audit log to the notification
  });

  return updatedSubscription;
};