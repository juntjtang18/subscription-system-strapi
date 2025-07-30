"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'DID_CHANGE_RENEWAL_PREF' notifications.
 * This function processes a plan change by creating a new subscription for the new plan
 * and marking the old one as 'switched'.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object|null} context.subscription - The existing subscription from the DB.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 * @param {string} context.notificationId - The ID of the saved notification entry for linking.
 */
module.exports = async ({
  strapi,
  subscription,
  notificationDetails,
  notificationId,
}) => {
  // If the subscription doesn't exist, it's a critical data issue.
  if (!subscription) {
    const message = `Received a 'DID_CHANGE_RENEWAL_PREF' notification, but the corresponding subscription does not exist. This is a critical data inconsistency.`;
    logger.error(
      `[Apple DID_CHANGE_RENEWAL_PREF Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
      event: "PLAN_CHANGE_FAILURE_SUB_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: null,
      apple_notification: notificationId, // Correctly link the audit log
    });
    throw new Error(message);
  }

  // Find the new plan the user has switched to.
  const newPlanId = notificationDetails.productId;
  const newPlan = await strapi.db.query("api::plan.plan").findOne({
    where: { appleProductId: newPlanId },
  });

  if (!newPlan) {
    const message = `User initiated a plan change to productId '${newPlanId}', but no corresponding plan was found in the database.`;
    logger.error(
      `[Apple DID_CHANGE_RENEWAL_PREF Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
      event: "PLAN_CHANGE_FAILURE_PLAN_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: subscription.strapiUserId,
      apple_notification: notificationId, // Correctly link the audit log
    });
    throw new Error(message);
  }

  const currentPlan = subscription.plan;
  const message = `User changed their subscription plan from '${currentPlan.name}' to '${newPlan.name}'.`;
  logger.info(
    `[Apple DID_CHANGE_RENEWAL_PREF Handler] ${message} - UUID: ${notificationDetails.uuid}`
  );

  // Record the successful plan change in the audit log.
  await auditLog({ strapi }).record({
    event: "PLAN_CHANGED",
    status: "SUCCESS",
    message,
    strapiUserId: subscription.strapiUserId,
    details: { ...notificationDetails, oldPlan: currentPlan, newPlan },
    apple_notification: notificationId, // Correctly link the audit log
  });

  // NOTE: We don't create a new subscription or change the status here.
  // The actual change will be confirmed by a subsequent 'DID_RENEW' or 'INTERACTIVE_RENEWAL' notification.
  // This event is purely informational about the user's intent.
};