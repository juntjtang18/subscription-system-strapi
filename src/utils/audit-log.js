// src/utils/audit-log.js
"use strict";

/**
 * Service for logging business audit events.
 */

module.exports = ({ strapi }) => ({
  /**
   * Records a new business event in the Audit Log.
   * @param {object} eventData
   * @param {string} eventData.event - The event name (e.g., 'APPLE_NOTIFICATION_FAILURE').
   * @param {'SUCCESS'|'FAILURE'|'WARNING'|'INFO'} eventData.status - The status of the event.
   * @param {string} eventData.message - A human-readable message.
   * @param {object} [eventData.details] - Optional JSON data.
   * @param {number} [eventData.user] - Optional ID of the related user.
   */
  async record(eventData) {
    try {
      await strapi.entityService.create("api::audit-log.audit-log", {
        data: {
          ...eventData,
          publishedAt: new Date(), // Ensure it's visible in the admin panel
        },
      });
    } catch (error) {
      // Use the technical logger to report if the audit log itself fails
      strapi.log.error("Failed to record to audit log:", error);
    }
  },
});