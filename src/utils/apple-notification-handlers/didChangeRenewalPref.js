"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'DID_CHANGE_RENEWAL_PREF' notifications.
 * This function updates the subscription's productId to reflect a user's
 * plan change (upgrade, downgrade, or crossgrade). The status does not change
 * as the new plan takes effect on the next renewal date.
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
  // If the subscription doesn't exist for this event, it's a critical data issue.
  if (!subscription) {
    const message = `Received a 'DID_CHANGE_RENEWAL_PREF' notification, but the corresponding subscription does not exist. This is a critical data inconsistency.`;
    logger.error(
      `[Apple DID_CHANGE_RENEWAL_PREF Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
      event: "RENEWAL_PREF_CHANGE_FAILURE_SUB_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: null,
    });
    throw new Error(message);
  }

  // The new product ID is in the transaction info of this notification.
  const { productId: newProductId } = transactionInfo;
  const changeType = notificationDetails.subtype || "UNKNOWN"; // UPGRADE, DOWNGRADE, etc.

  // Avoid updating if the product ID is somehow the same.
  if (subscription.productId === newProductId) {
    logger.warn(
      `Received DID_CHANGE_RENEWAL_PREF for user ${subscription.strapiUserId}, but productId is unchanged. Ignoring.`
    );
    return;
  }

  logger.info(
    `Handling ${changeType} for user ${subscription.strapiUserId}. New plan: ${newProductId}.`
  );

  await strapi.entityService.update(
    "api::subscription.subscription",
    subscription.id,
    {
      data: {
        // Update the productId to the new plan.
        productId: newProductId,
      },
    }
  );

  await auditLog({ strapi }).record({
    event: "USER_CHANGED_PLAN",
    status: "INFO",
    message: `User initiated a plan change (${changeType}) to '${newProductId}'. This will take effect at next renewal.`,
    strapiUserId: subscription.strapiUserId,
    details: notificationDetails,
  });
};