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
  const { productId } = transactionInfo;
  const reason = notificationDetails.subtype || "UNKNOWN";
  const updatedSubscription = await strapi.entityService.update(
    "api::subscription.subscription",
    subscription.id,
    { data: { status: "expired" } }
  );
  await auditLog({ strapi }).record({
    event: "USER_SUBSCRIPTION_EXPIRED",
    status: "INFO",
    message: `Subscription for plan '${productId}' expired. Reason: ${reason}.`,
    strapiUserId: updatedSubscription.strapiUserId,
    details: notificationDetails,
    apple_notification: notificationId, // Link the audit log
  });
  return updatedSubscription;
};