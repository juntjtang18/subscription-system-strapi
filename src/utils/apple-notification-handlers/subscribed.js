"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

module.exports = async ({
  strapi,
  subscription,
  transactionInfo,
  notificationDetails,
}) => {
  const { appAccountToken, originalTransactionId, productId, expiresDate } =
    transactionInfo;

  const strapiUserId = appAccountToken ? parseInt(appAccountToken, 10) : null;

  if (!strapiUserId) {
    // ... (error handling for missing strapiUserId remains the same)
    const message = `Cannot process SUBSCRIBED event because the appAccountToken (strapiUserId) is missing from the transaction.`;
    logger.error(`[Apple SUBSCRIBED Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`);
    await auditLog({ strapi }).record({ /* ... */ });
    throw new Error(message);
  }

  // --- Primary Path: Subscription already exists ---
  if (subscription) {
    // ... (this logic remains the same, it just confirms/syncs the existing record)
    logger.info(`Confirming subscription for strapiUserId: ${strapiUserId}. Sub ID: ${subscription.id}`);
    const updatedSubscription = await strapi.entityService.update(/* ... */);
    await auditLog({ strapi }).record({ /* ... */ });
    return updatedSubscription;
  }

  // --- Fallback Path: Subscription does NOT exist ---
  else {
    logger.warn(
      `Subscription for user ${strapiUserId} not found. Creating from notification as a fallback.`
    );

    // **UPDATED LOGIC TO ENSURE CONSISTENCY**
    // Find and cancel any subscriptions that are not in a terminal state.
    const liveStatuses = ["active", "grace-period", "billing-issue", "cancelled"];
    const existingLiveSubs = await strapi.db
      .query("api::subscription.subscription")
      .findMany({
        where: {
          strapiUserId: strapiUserId,
          status: { $in: liveStatuses }, // Find any "live" subscription
        },
      });

    for (const sub of existingLiveSubs) {
      logger.warn(
        `Found and cancelling previous subscription ${sub.id} (status: ${sub.status}) for user ${strapiUserId} before creating new one.`
      );
      await strapi.entityService.update(
        "api::subscription.subscription",
        sub.id,
        // We set it to 'cancelled' because its lifecycle was interrupted by a new purchase.
        { data: { status: "cancelled" } }
      );
      await auditLog({ strapi }).record({
        event: "EXISTING_SUBSCRIPTION_SUPERSEDED",
        status: "INFO",
        message: `Deactivated old subscription (ID: ${sub.id}, Status: ${sub.status}) due to a new purchase.`,
        strapiUserId: strapiUserId,
        details: { oldSubscriptionId: sub.id, ...notificationDetails },
      });
    }

    // Now, create the new subscription record.
    const newSubscription = await strapi.entityService.create(
      "api::subscription.subscription",
      {
        data: {
          strapiUserId,
          originalTransactionId,
          status: "active",
          productId,
          expiresDate: new Date(expiresDate),
          publishedAt: new Date(),
        },
      }
    );

    await auditLog({ strapi }).record({
      event: "SUBSCRIPTION_CREATED_BY_FALLBACK",
      status: "WARNING",
      message: `Subscription for plan '${productId}' was created by server notification fallback.`,
      strapiUserId: newSubscription.strapiUserId,
      details: notificationDetails,
    });
    return newSubscription;
  }
};