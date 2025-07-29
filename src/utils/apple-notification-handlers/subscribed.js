"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

module.exports = async ({
  strapi,
  subscription,
  transactionInfo,
  notificationDetails,
  notificationId,
}) => {
  const { appAccountToken, originalTransactionId, productId, expiresDate } =
    transactionInfo;

  // The correct, new expiration date from Apple.
  const correctExpiresDate = new Date(expiresDate);
  const strapiUserId = appAccountToken ? parseInt(appAccountToken, 10) : null;
  logger.info(`[SUBSCRIBED Handler] Processing notification for subscription ID: ${subscription?.id} and transaction ID: ${transactionInfo.transactionId}`);

  if (subscription) {
    logger.info(
      `Handling SUBSCRIBED for existing subscription (ID: ${
        subscription.id
      }). User: ${
        subscription.strapiUserId
      }. New expireDate from Apple: ${correctExpiresDate.toISOString()}`
    );

    const dataToUpdate = {
      status: "active",
      expireDate: correctExpiresDate, // ✨ FIX: Changed 'expiresDate' to 'expireDate'
      productId,
    };

    await strapi.entityService.update(
      "api::subscription.subscription",
      subscription.id,
      { data: dataToUpdate }
    );

    // This log confirms the update command was sent.
    logger.info(
      `[SUCCESS] Subscription ${subscription.id} update command sent. Expires date is now set to ${correctExpiresDate.toISOString()}`
    );

    // Add the link to the apple_notification record.
    await auditLog({ strapi }).record({
      event: "SUBSCRIPTION_CONFIRMED_OR_REACTIVATED",
      status: "SUCCESS",
      message: `Subscription for plan '${productId}' was confirmed as active.`,
      strapiUserId: subscription.strapiUserId,
      details: notificationDetails,
      apple_notification: notificationId,
    });
    return;

  } else if (strapiUserId) {
    // Fallback logic to create a subscription if one doesn't exist.
    const newSubscription = await strapi.entityService.create(
      "api::subscription.subscription",
      {
        data: {
          strapiUserId,
          originalTransactionId,
          status: "active",
          productId,
          expireDate: correctExpiresDate, // ✨ FIX: Changed 'expiresDate' to 'expireDate'
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
      apple_notification: notificationId,
    });
    return newSubscription;

  } else {
    // Logic for unlikable subscription failure.
    const message = `Cannot process SUBSCRIBED event: No appAccountToken (strapiUserId) was provided, and no existing subscription was found for this originalTransactionId.`;
    logger.error(
      `[Apple SUBSCRIBED Handler] FATAL: ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
      event: "SUBSCRIBED_FAILURE_UNLINKABLE",
      status: "FAILURE",
      message,
      details: notificationDetails,
      strapiUserId: null,
      apple_notification: notificationId,
    });
    throw new Error(message);
  }
};