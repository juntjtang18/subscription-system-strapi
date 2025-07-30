"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'OFFER_REDEEMED' notifications.
 * This is primarily an informational event for tracking marketing effectiveness.
 * No state change is needed as a SUBSCRIBED or DID_RENEW event handles the actual transaction.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object|null} context.subscription - The existing subscription from the DB.
 * @param {object} context.transactionInfo - Decoded transaction info from Apple.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 * @param {string} context.notificationId - The ID of the saved notification entry for linking.
 */
module.exports = async ({
  strapi,
  subscription,
  transactionInfo,
  notificationDetails,
  notificationId
}) => {
  // We don't throw an error if the subscription isn't found, as this is informational.
  if (!subscription) {
    const message = `Received an 'OFFER_REDEEMED' notification, but could not find a matching subscription. The event was still logged for analytics.`;
    logger.warn(
      `[Apple OFFER_REDEEMED Handler] ${message} - UUID: ${notificationDetails.uuid}`
    );
    // Log the event anyway, just without a user ID.
    await auditLog({ strapi }).record({
        event: "OFFER_REDEEMED_SUB_MISSING",
        status: "WARNING",
        message,
        details: notificationDetails,
        strapiUserId: null,
        apple_notification: notificationId,
      });
    return;
  }

  const { offerType, offerIdentifier } = transactionInfo;
  const offerTypeMap = { 1: "Introductory", 2: "Promotional", 3: "Offer Code"};

  const message = `User redeemed an offer ('${offerIdentifier || "N/A"}', Type: ${offerTypeMap[offerType] || "Unknown"}).`;

  logger.info(
    `[Apple OFFER_REDEEMED Handler] ${message} - User: ${subscription.strapiUserId}`
  );

  await auditLog({ strapi }).record({
    event: "USER_REDEEMED_OFFER",
    status: "INFO",
    message,
    strapiUserId: subscription.strapiUserId,
    details: {
        ...notificationDetails,
        offerIdentifier,
        offerType: offerTypeMap[offerType] || "Unknown"
    },
    apple_notification: notificationId,
  });
};