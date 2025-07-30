'use strict';

const auditLog = require('../audit-log');
const logger = require('../logger');

/**
 * Handles 'DID_RENEW' notifications.
 * This function is triggered when a subscription successfully auto-renews.
 * It updates the subscription's expiration date and status.
 * It also handles cases where the renewal is for a different plan (e.g., after an upgrade/downgrade)
 * or when a plan is being associated for the first time.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object} context.subscription - The existing subscription from the DB (with relations populated).
 * @param {object} context.transactionInfo - The JWS transaction info from the notification.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 */
module.exports = async ({ strapi, subscription, transactionInfo, notificationDetails }) => {
  // If the subscription doesn't exist, it's a critical data issue.
  if (!subscription) {
    const message = `Received a 'DID_RENEW' notification, but the corresponding subscription does not exist. This is a critical data inconsistency.`;
    logger.error(`[Apple DID_RENEW Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`);
    await auditLog({ strapi }).record({
      event: "RENEWAL_FAILURE_SUB_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: null,
    });
    throw new Error(message);
  }

  const newProductId = transactionInfo.productId;
  const newExpiresDate = transactionInfo.expiresDate;
  const currentPlan = subscription.plan; // This can be null.
  //logger.debug(`currentPlan: ${currentPlan ? currentPlan.productId : 'None'}`);

  let planChanged = false;
  let newPlanId = currentPlan ? currentPlan.id : null;

  // Check if the plan has changed or if one is being assigned for the first time.
  if (!currentPlan || currentPlan.productId !== newProductId) {
    logger.info(`[Apple DID_RENEW Handler] Renewal involves a plan change. Old Product ID: ${currentPlan ? currentPlan.productId : 'None'}, New Product ID: ${newProductId}. Sub ID: ${subscription.id}`);
    planChanged = true;

    // Find the new plan in the database.
    const plans = await strapi.entityService.findMany("api::plan.plan", {
      filters: { productId: newProductId },
    });

    if (!plans || plans.length === 0) {
      const message = `User ${subscription.strapiUserId} renewed with a new plan (${newProductId}), but no corresponding plan was found in the database.`;
      logger.error(`[Apple DID_RENEW Handler] ${message} - Sub ID: ${subscription.id}`);
      await auditLog({ strapi }).record({
        event: "RENEWAL_FAILURE_PLAN_MISSING",
        status: "FAILURE",
        message,
        strapiUserId: subscription.strapiUserId,
        details: { ...notificationDetails, transactionInfo },
      });
      // Throw an error to signal a configuration problem.
      throw new Error(message);
    }
    newPlanId = plans[0].id;
  }

  // Prepare the data for the update. The status is now active, and the expiration date is extended.
  const updateData = {
    status: 'active',
    expiresDate: new Date(newExpiresDate),
    // Only include the plan in the update if it has actually changed.
    ...(planChanged && { plan: newPlanId }),
  };

  // Update the subscription in the database.
  await strapi.entityService.update(
    "api::subscription.subscription",
    subscription.id,
    {
      data: updateData,
    }
  );

  // Log the appropriate message based on whether the plan changed.
  if (planChanged) {
    const newPlan = await strapi.entityService.findOne("api::plan.plan", newPlanId);
    const oldPlanDetails = currentPlan ? `'${currentPlan.name}' (${currentPlan.productId})` : 'None';
    const message = `Subscription renewed and plan changed from ${oldPlanDetails} to '${newPlan.name}' (${newPlan.productId}). New expiration: ${new Date(newExpiresDate).toISOString()}`;
    logger.info(`[Apple DID_RENEW Handler] ${message} - User ID: ${subscription.strapiUserId}, Sub ID: ${subscription.id}`);
    await auditLog({ strapi }).record({
      event: "RENEWAL_WITH_PLAN_CHANGE",
      status: "SUCCESS",
      message,
      strapiUserId: subscription.strapiUserId,
      details: { ...notificationDetails, transactionInfo, oldPlan: currentPlan, newPlan },
    });
  } else {
    const message = `Subscription successfully renewed. New expiration: ${new Date(newExpiresDate).toISOString()}`;
    logger.info(`[Apple DID_RENEW Handler] ${message} - User ID: ${subscription.strapiUserId}, Sub ID: ${subscription.id}`);
    await auditLog({ strapi }).record({
      event: "RENEWAL_SUCCESS",
      status: "SUCCESS",
      message,
      strapiUserId: subscription.strapiUserId,
      details: { ...notificationDetails, transactionInfo },
    });
  }
};
