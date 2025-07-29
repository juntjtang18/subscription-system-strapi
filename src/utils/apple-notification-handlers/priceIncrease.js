"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'PRICE_INCREASE' notifications.
 * This is an informational event to log that a user has been notified of
 * a price increase and whether they have consented.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object|null} context.subscription - The existing subscription from the DB.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 */
module.exports = async ({
  strapi,
  subscription,
  notificationDetails,
}) => {
  if (!subscription) {
    const message = `Received a 'PRICE_INCREASE' notification, but the corresponding subscription does not exist. The event was still logged.`;
    logger.warn(
      `[Apple PRICE_INCREASE Handler] ${message} - UUID: ${notificationDetails.uuid}`
    );
    await auditLog({ strapi }).record({
        event: "PRICE_INCREASE_WARNING_SUB_MISSING",
        status: "WARNING",
        message,
        details: notificationDetails,
        strapiUserId: null,
      });
    return;
  }

  const subtype = notificationDetails.subtype; // PENDING or ACCEPTED
  let message;

  if (subtype === 'ACCEPTED') {
      message = `User has accepted the upcoming price increase for their subscription.`;
  } else {
      message = `User has been notified of an upcoming price increase and has not yet accepted.`;
  }

  logger.info(
    `[Apple PRICE_INCREASE Handler] ${message} - User: ${subscription.strapiUserId}`
  );

  await auditLog({ strapi }).record({
    event: "USER_NOTIFIED_OF_PRICE_INCREASE",
    status: "INFO",
    message,
    strapiUserId: subscription.strapiUserId,
    details: notificationDetails,
  });
};