"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'SUBSCRIBED' notifications.
 * This function is triggered for a new subscription or when a lapsed subscription is reactivated.
 * It creates a new subscription or updates an existing one, ensuring the correct plan is associated.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object} context.subscription - The existing subscription from the DB (with relations populated).
 * @param {object} context.transactionInfo - The JWS transaction info from the notification.
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
  const {
    appAccountToken,
    originalTransactionId,
    productId: newProductId,
    transactionId,
    expiresDate,
  } = transactionInfo;

  const strapiUserId = appAccountToken ? parseInt(appAccountToken, 10) : null;
  const newExpireDate = new Date(expiresDate);

  // --- Case 1: An existing subscription was found (e.g., reactivation) ---
  if (subscription) {
    const currentPlan = subscription.plan;
    let planChanged = false;
    let newPlanId;

    // Check if the plan has changed or was never assigned.
    if (!currentPlan || currentPlan.productId !== newProductId) {
      planChanged = true;
      logger.info(
        `[SUBSCRIBED Handler] Notification for Sub ID ${subscription.id} involves a plan change or initial assignment to '${newProductId}'.`
      );

      const plans = await strapi.entityService.findMany("api::plan.plan", {
        filters: { productId: newProductId },
      });

      if (!plans || plans.length === 0) {
        const message = `Cannot process SUBSCRIBED event: The plan with productId '${newProductId}' was not found in the database.`;
        logger.error(`[SUBSCRIBED Handler] FATAL: ${message}`);
        await auditLog({ strapi }).record({
          event: "SUBSCRIBED_FAILURE_PLAN_MISSING",
          status: "FAILURE",
          message,
          strapiUserId: subscription.strapiUserId,
          details: { ...notificationDetails, transactionInfo },
          apple_notification: notificationId,
        });
        throw new Error(message);
      }
      newPlanId = plans[0].id;
    }

    // Prepare data for the update.
    const dataToUpdate = {
      status: "active",
      expireDate: newExpireDate,
      latestTransactionId: transactionId,
      // Only include the plan if it's being changed or assigned for the first time.
      ...(planChanged && { plan: newPlanId }),
    };

    await strapi.entityService.update(
      "api::subscription.subscription",
      subscription.id,
      { data: dataToUpdate }
    );

    const planDetails = planChanged ? `and set to plan '${newProductId}'` : "";
    const message = `Subscription ${subscription.id} confirmed as active ${planDetails}. New expiration: ${newExpireDate.toISOString()}`;
    logger.info(`[SUBSCRIBED Handler] ${message}`);
    await auditLog({ strapi }).record({
      event: "SUBSCRIPTION_CONFIRMED",
      status: "SUCCESS",
      message,
      strapiUserId: subscription.strapiUserId,
      details: notificationDetails,
      apple_notification: notificationId,
    });

    return;
  }

  // --- Case 2: No subscription found, but we have a user ID (create new) ---
  if (strapiUserId) {
    logger.warn(
      `[SUBSCRIBED Handler] No existing subscription found for originalTransactionId '${originalTransactionId}'. Creating a new one for user ${strapiUserId} via webhook fallback.`
    );

    // Find the plan to associate with the new subscription.
    const plans = await strapi.entityService.findMany("api::plan.plan", {
      filters: { productId: newProductId },
    });

    if (!plans || plans.length === 0) {
      const message = `Cannot create subscription for user ${strapiUserId}: The plan with productId '${newProductId}' was not found in the database.`;
      logger.error(`[SUBSCRIBED Handler] FATAL: ${message}`);
      await auditLog({ strapi }).record({
        event: "SUBSCRIBED_FAILURE_PLAN_MISSING",
        status: "FAILURE",
        message,
        strapiUserId,
        details: notificationDetails,
        apple_notification: notificationId,
      });
      throw new Error(message);
    }
    const newPlanId = plans[0].id;

    // Create the new subscription record.
    await strapi.entityService.create("api::subscription.subscription", {
      data: {
        strapiUserId,
        originalTransactionId,
        latestTransactionId: transactionId,
        status: "active",
        expireDate: newExpireDate,
        plan: newPlanId,
        publishedAt: new Date(),
      },
    });

    const message = `New subscription created for plan '${newProductId}' via webhook fallback.`;
    await auditLog({ strapi }).record({
      event: "SUBSCRIPTION_CREATED_BY_FALLBACK",
      status: "SUCCESS",
      message,
      strapiUserId,
      details: notificationDetails,
      apple_notification: notificationId,
    });

    return;
  }

  // --- Case 3: Cannot process (no subscription and no user ID) ---
  const message = `Cannot process SUBSCRIBED event: No appAccountToken was provided, and no existing subscription was found.`;
  logger.error(`[SUBSCRIBED Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`);
  await auditLog({ strapi }).record({
    event: "SUBSCRIBED_FAILURE_UNLINKABLE",
    status: "FAILURE",
    message,
    details: notificationDetails,
    strapiUserId: null,
    apple_notification: notificationId,
  });
  throw new Error(message);
};