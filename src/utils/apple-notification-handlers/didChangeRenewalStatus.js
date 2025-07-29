"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'DID_CHANGE_RENEWAL_STATUS' notifications.
 * This function updates the subscription status to 'cancelled' when a user
 * turns off auto-renew, or back to 'active' if they re-enable it.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object|null} context.subscription - The existing subscription from the DB.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 */
module.exports = async ({
  strapi,
  subscription,
  notificationDetails,
}) => {
  // If the subscription doesn't exist for this event, it's a critical data issue.
  if (!subscription) {
    const message = `Received a 'DID_CHANGE_RENEWAL_STATUS' notification, but the corresponding subscription does not exist. This is a critical data inconsistency.`;
    logger.error(
      `[Apple DID_CHANGE_RENEWAL_STATUS Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
      event: "RENEWAL_STATUS_CHANGE_FAILURE_SUB_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: null,
    });
    throw new Error(message);
  }

  const subtype = notificationDetails.subtype;
  let newStatus = subscription.status; // Default to current status
  let auditMessage;
  let eventType;

  // User turned off auto-renew.
  if (subtype === "AUTO_RENEW_DISABLED") {
    newStatus = "cancelled";
    eventType = "USER_DISABLED_AUTORENEW";
    auditMessage = `User turned off auto-renew. Subscription will expire at the end of the current period.`;
    logger.info(`User ${subscription.strapiUserId} disabled auto-renew for sub ${subscription.id}.`);
  }
  // User turned auto-renew back on.
  else if (subtype === "AUTO_RENEW_ENABLED") {
    // Only update if the status was something recoverable like 'cancelled'.
    // Don't change it if it's already 'expired' or 'revoked'.
    if (["cancelled", "billing-issue", "grace-period"].includes(subscription.status)) {
        newStatus = "active";
    }
    eventType = "USER_ENABLED_AUTORENEW";
    auditMessage = `User re-enabled auto-renew.`;
    logger.info(`User ${subscription.strapiUserId} enabled auto-renew for sub ${subscription.id}.`);
  }
  // If subtype is unknown or status doesn't need changing, we can just log and exit.
  else {
      logger.warn(`Received DID_CHANGE_RENEWAL_STATUS with unhandled subtype: ${subtype}`);
      return;
  }
  
  // Only update if the status has actually changed.
  if (newStatus !== subscription.status) {
    await strapi.entityService.update(
      "api::subscription.subscription",
      subscription.id,
      {
        data: {
          status: newStatus,
        },
      }
    );
  }
  
  await auditLog({ strapi }).record({
    event: eventType,
    status: "INFO",
    message: auditMessage,
    strapiUserId: subscription.strapiUserId,
    details: notificationDetails,
  });
};