"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'DID_RENEW' notifications.
 * This function updates the expiration date for a successfully auto-renewed subscription.
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
  // If the subscription doesn't exist for a renewal event, it's a critical data issue.
  if (!subscription) {
    const message = `Received a 'DID_RENEW' notification, but the corresponding subscription does not exist in the database. This is a critical data inconsistency.`;
    logger.error(
      `[Apple DID_RENEW Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
      event: "RENEWAL_FAILURE_SUBSCRIPTION_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: null, // We don't know the user if we can't find the sub
    });
    // Throw an error to ensure Apple retries, giving time to fix the data issue.
    throw new Error(message);
  }

  // --- Primary Path: Update the existing subscription ---
  const { productId, expiresDate } = transactionInfo;

  logger.info(
    `Handling DID_RENEW for strapiUserId: ${subscription.strapiUserId}. New expiry: ${new Date(expiresDate).toISOString()}`
  );

  const updatedSubscription = await strapi.entityService.update(
    "api::subscription.subscription",
    subscription.id,
    {
      data: {
        status: "active", // Ensure status remains active
        expiresDate: new Date(expiresDate), // Update the expiration date
        productId, // Ensure product ID is current
      },
    }
  );

  await auditLog({ strapi }).record({
    event: "USER_SUBSCRIPTION_RENEWED",
    status: "SUCCESS",
    message: `Subscription for plan '${productId}' successfully auto-renewed.`,
    strapiUserId: updatedSubscription.strapiUserId,
    details: notificationDetails,
  });

  return updatedSubscription;
};