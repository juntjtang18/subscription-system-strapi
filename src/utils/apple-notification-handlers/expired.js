'use strict';

const auditLog = require('../audit-log');
const logger = require('../logger');

/**
 * Handles 'EXPIRED' notifications.
 * This function marks the user's paid subscription as expired and then
 * creates a new, active subscription linked to the default free plan.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object} context.subscription - The existing subscription from the DB.
 * @param {object} context.transactionInfo - Decoded transaction info from Apple.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 * @param {string} context.notificationId - The ID of the saved notification entry.
 */
module.exports = async ({ strapi, subscription, transactionInfo, notificationDetails, notificationId }) => {
  if (!subscription) {
    const message = `Received an 'EXPIRED' notification, but the corresponding subscription does not exist. This is a critical data inconsistency.`;
    logger.error(`[EXPIRED Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`);
    await auditLog({ strapi }).record({
      event: "EXPIRATION_FAILURE_SUB_MISSING",
      status: "FAILURE",
      message,
      details: notificationDetails,
      apple_notification: notificationId,
    });
    throw new Error(message);
  }

  const FREE_PLAN_PRODUCT_ID = 'gpa-free-plan'; // Your constant for the free plan

  logger.info(`[EXPIRED Handler] Processing expiration for Sub ID: ${subscription.id} for user ${subscription.strapiUserId}.`);

  // --- Step 1: Mark the old subscription as expired ---
  await strapi.entityService.update(
    'api::subscription.subscription',
    subscription.id,
    {
      data: { status: 'expired' },
    }
  );

  await auditLog({ strapi }).record({
    event: "USER_SUBSCRIPTION_EXPIRED",
    status: "INFO",
    message: `Subscription ${subscription.id} for plan '${subscription.plan.productId}' has expired.`,
    strapiUserId: subscription.strapiUserId,
    details: notificationDetails,
    apple_notification: notificationId,
  });

  // --- Step 2: Find the default "Free Plan" ---
  const freePlans = await strapi.entityService.findMany("api::plan.plan", {
    filters: { productId: FREE_PLAN_PRODUCT_ID },
  });

  if (!freePlans || freePlans.length === 0) {
    const message = `Could not transition user ${subscription.strapiUserId} to free plan because the plan with productId '${FREE_PLAN_PRODUCT_ID}' was not found.`;
    logger.error(`[EXPIRED Handler] FATAL: ${message}`);
    // Log this critical failure but do not throw, as the primary subscription was already marked expired.
    await auditLog({ strapi }).record({
      event: "EXPIRATION_FAILURE_FREE_PLAN_MISSING",
      status: "FAILURE",
      message,
      strapiUserId: subscription.strapiUserId,
      details: notificationDetails,
      apple_notification: notificationId,
    });
    return;
  }
  const freePlan = freePlans[0];

  // --- Step 3: Create a new, active subscription for the free plan ---
  // Note: We use the *original* transaction ID as a stable link to the user's purchase history.
  const newFreeSubscription = await strapi.entityService.create('api::subscription.subscription', {
    data: {
      strapiUserId: subscription.strapiUserId,
      originalTransactionId: subscription.originalTransactionId,
      status: 'active', // The free plan is always active
      expireDate: null, // Free plans do not expire
      startDate: new Date(),
      plan: freePlan.id,
      publishedAt: new Date(),
    },
  });

  const successMessage = `Successfully transitioned user ${subscription.strapiUserId} to free plan (New Sub ID: ${newFreeSubscription.id}).`;
  logger.info(`[EXPIRED Handler] ${successMessage}`);
  await auditLog({ strapi }).record({
    event: "USER_TRANSITIONED_TO_FREE",
    status: "SUCCESS",
    message: successMessage,
    strapiUserId: subscription.strapiUserId,
    details: { oldSubscriptionId: subscription.id, newSubscriptionId: newFreeSubscription.id },
    apple_notification: notificationId,
  });
};