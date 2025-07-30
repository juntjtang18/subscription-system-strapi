"use strict";

const auditLog = require("../audit-log");
const logger = require("../logger");

/**
 * Handles 'TEST' notifications.
 * This is a simple health check from Apple to confirm the endpoint is working.
 * No action is needed other than logging the successful receipt.
 *
 * @param {object} context - The context object.
 * @param {object} context.strapi - The Strapi instance.
 * @param {object} context.notificationDetails - Our custom object with UUID, type, etc.
 * @param {string} context.notificationId - The ID of the saved notification entry for linking.
 */
module.exports = async ({ strapi, notificationDetails, notificationId }) => {
  const message = `Successfully received a 'TEST' notification from Apple. The endpoint is working correctly.`;

  logger.info(`[Apple TEST Handler] ${message}`);

  await auditLog({ strapi }).record({
    event: "TEST_NOTIFICATION_RECEIVED",
    status: "INFO",
    message,
    strapiUserId: null, // Test notifications are not associated with a user.
    details: notificationDetails,
    apple_notification: notificationId, // Link the audit log to the notification
  });
};