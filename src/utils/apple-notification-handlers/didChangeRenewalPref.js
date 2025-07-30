'use strict';

const auditLog = require('../audit-log');
const logger = require("../logger");

/**
 * Handles 'DID_CHANGE_RENEWAL_PREF' notifications.
 * This notification is sent when a user upgrades, downgrades, or crossgrades their subscription.
 * This handler updates the plan associated with the subscription based on the new productId.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object} context.subscription - The existing subscription from the DB (with relations populated).
 * @param {object} context.transactionInfo - The JWS transaction info from the notification.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 * @param {string} context.notificationId - The ID of the saved notification entry for linking.
 */
module.exports = async ({ strapi, subscription, transactionInfo, notificationDetails, notificationId }) => {
  // If the subscription doesn't exist, it's a critical data issue.
  if (!subscription) {
    const message = `Received a 'DID_CHANGE_RENEWAL_PREF' notification, but the corresponding subscription does not exist. This is a critical data inconsistency.`;
    logger.error(`[Apple DID_CHANGE_RENEWAL_PREF Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`);
    await auditLog({ strapi }).record({
      event: "PLAN_CHANGE_FAILURE_SUB_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: null,
      apple_notification: notificationId, // Link the audit log to the notification
    });
    throw new Error(message);
  }

  const newProductId = transactionInfo.productId;
  const currentPlan = subscription.plan;
  
  // It's possible to get this notification even if the product ID hasn't changed.
  // We only act if the plan is actually different.
  if (currentPlan && currentPlan.productId === newProductId) {
    logger.info(`[Apple DID_CHANGE_RENEWAL_PREF Handler] Received notification for plan change, but the productId (${newProductId}) is the same as the current plan. No action taken. Sub ID: ${subscription.id}`);
    return;
  }

  // Find the new plan in the database using the new Apple Product ID.
  const plans = await strapi.entityService.findMany("api::plan.plan", {
    filters: { productId: newProductId },
  });

  // If we can't find the plan, it's a configuration error (the plan exists in App Store Connect but not in our DB).
  if (!plans || plans.length === 0) {
    const message = `User ${subscription.strapiUserId} changed to a new plan (${newProductId}), but no corresponding plan was found in the database.`;
    logger.error(`[Apple DID_CHANGE_RENEWAL_PREF Handler] ${message} - Sub ID: ${subscription.id}`);
    await auditLog({ strapi }).record({
      event: "PLAN_CHANGE_FAILURE_PLAN_MISSING",
      status: "FAILURE",
      message,
      strapiUserId: subscription.strapiUserId,
      details: { ...notificationDetails, transactionInfo },
      apple_notification: notificationId, // Link the audit log to the notification
    });
    // We throw an error because this is a configuration issue that needs to be fixed.
    throw new Error(message);
  }

  const newPlan = plans[0];
  //logger.debug(`newPlan: ${JSON.stringify(newPlan)}`);
  // Update the subscription to point to the new plan.
  await strapi.entityService.update(
    "api::subscription.subscription",
    subscription.id,
    {
      data: {
        plan: newPlan.id, // This correctly updates the relation.
      },
    }
  );

  const message = `User successfully changed plan from '${currentPlan.name}' (${currentPlan.productId}) to '${newPlan.name}' (${newPlan.productId}). The change will take effect on the next renewal.`;
  logger.info(`[Apple DID_CHANGE_RENEWAL_PREF Handler] ${message} - User ID: ${subscription.strapiUserId}, Sub ID: ${subscription.id}`);

  // Record the successful plan change in the audit log.
  await auditLog({ strapi }).record({
    event: "PLAN_CHANGED",
    status: "SUCCESS",
    message,
    strapiUserId: subscription.strapiUserId,
    details: { ...notificationDetails, oldPlan: currentPlan, newPlan },
    apple_notification: notificationId, // Link the audit log to the notification
  });
};
