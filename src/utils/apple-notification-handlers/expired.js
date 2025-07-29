"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'EXPIRED' notifications.
 * This function marks a subscription as 'expired' in the local database.
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
  // If the subscription doesn't exist for an expiration event, it's a data issue.
  if (!subscription) {
    const message = `Received an 'EXPIRED' notification, but the corresponding subscription does not exist. This could happen if the subscription was already removed.`;
    // We log this as a warning because the end state (no active sub) is correct.
    logger.warn(
      `[Apple EXPIRED Handler] ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
      event: "EXPIRATION_WARNING_SUBSCRIPTION_MISSING",
      status: "WARNING",
      message,
      details: notificationDetails,
      strapiUserId: null,
    });
    // We don't throw an error because there's nothing to retry.
    return;
  }

  // --- Primary Path: Update the subscription status to 'expired' ---
  const { productId } = transactionInfo;
  const reason = notificationDetails.subtype || "UNKNOWN"; // e.g., 'VOLUNTARY'

  logger.info(
    `Handling EXPIRED for strapiUserId: ${subscription.strapiUserId}. Reason: ${reason}`
  );

  const updatedSubscription = await strapi.entityService.update(
    "api::subscription.subscription",
    subscription.id,
    {
      data: {
        status: "expired", // Set status to expired
      },
    }
  );

  await auditLog({ strapi }).record({
    event: "USER_SUBSCRIPTION_EXPIRED",
    status: "INFO", // Expiration is a standard lifecycle event, not a success/failure.
    message: `Subscription for plan '${productId}' expired. Reason: ${reason}.`,
    strapiUserId: updatedSubscription.strapiUserId,
    details: notificationDetails,
  });

  return updatedSubscription;
};