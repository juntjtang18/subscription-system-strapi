"use strict";
const auditLog = require("../audit-log");
const logger = require("../logger");

module.exports = async ({
  strapi,
  subscription,
  transactionInfo,
  notificationDetails,
  notificationId, // Accept notificationId
}) => {
  if (!subscription) {
    // ... error handling
    return;
  }
  const { productId, expiresDate } = transactionInfo;
  const updatedSubscription = await strapi.entityService.update(
    "api::subscription.subscription",
    subscription.id,
    {
      data: {
        status: "active",
        expireDate: new Date(expiresDate), // ✨ FIX: Changed 'expiresDate' to 'expireDate'
        productId,
      },
    }
  );
  await auditLog({ strapi }).record({
    event: "USER_SUBSCRIPTION_RENEWED",
    status: "SUCCESS",
    message: `Subscription for plan '${productId}' successfully auto-renewed.`,
    strapiUserId: updatedSubscription.strapiUserId,
    details: notificationDetails,
    apple_notification: notificationId, // Link the audit log
  });
  return updatedSubscription;
};