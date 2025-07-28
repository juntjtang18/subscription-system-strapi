'use strict';

const logger = require('./logger');
const jwt = require('jsonwebtoken');
const axios = require('axios');
const { verifyAppleJWS } = require('./apple-jws-verifier');

// Helper to generate the API token
const generateAppleApiToken = () => {
    const privateKey = process.env.APPLE_PRIVATE_KEY;
    const issuerId = process.env.APPLE_ISSUER_ID;
    const keyId = process.env.APPLE_KEY_ID;
    const bundleId = process.env.APPLE_BUNDLE_ID;

    if (!privateKey || !issuerId || !keyId || !bundleId) {
        logger.error('[CRON HELPER] Apple API credentials are not configured.');
        return null;
    }

    const formattedPrivateKey = privateKey.replace(/\\n/g, '\n');
    const payload = {
        iss: issuerId,
        iat: Math.floor(Date.now() / 1000),
        exp: Math.floor(Date.now() / 1000) + 300, // 5 minute expiry
        aud: 'appstoreconnect-v1',
        bid: bundleId
    };
    const options = { algorithm: 'ES256', header: { alg: 'ES256', kid: keyId } };
    return jwt.sign(payload, formattedPrivateKey, options);
};

const APPLE_API_BASE_URL = process.env.APPLE_ENVIRONMENT === 'production'
    ? 'https://api.storekit.itunes.apple.com'
    : 'https://api.storekit-sandbox.itunes.com';

/**
 * Finds pending Apple receipts and attempts to verify them with Apple's servers.
 * @param {object} strapi - The Strapi instance.
 */
const doubleCheckAppleReceipts = async (strapi) => {
    logger.info('[CRON JOB] Starting: doubleCheckAppleReceipts');
    const MAX_ATTEMPTS = 72; // Stop retrying after ~3 days (if job runs hourly)

    const pendingReceipts = await strapi.entityService.findMany('api::apple-receipt.apple-receipt', {
        filters: {
            status: 'pending_verification',
            verificationAttempts: { $lt: MAX_ATTEMPTS },
        },
        limit: 50, // Process up to 50 receipts per run
    });

    if (pendingReceipts.length === 0) {
        logger.info('[CRON JOB] Finished: No pending receipts to verify.');
        return;
    }

    logger.info(`[CRON JOB] Found ${pendingReceipts.length} receipt(s) to process.`);
    const appleApiToken = generateAppleApiToken();
    if (!appleApiToken) {
        logger.error('[CRON JOB] Halting: Could not generate Apple API token. Check configuration.');
        return;
    }

    for (const receipt of pendingReceipts) {
        // Increment attempt counter immediately
        await strapi.entityService.update('api::apple-receipt.apple-receipt', receipt.id, {
            data: {
                verificationAttempts: (receipt.verificationAttempts || 0) + 1,
                lastAttemptAt: new Date().toISOString(),
            },
        });

        try {
            const url = `${APPLE_API_BASE_URL}/inApps/v2/transactions/${receipt.transactionId}`;
            const response = await axios.get(url, { headers: { 'Authorization': `Bearer ${appleApiToken}` } });

            if (response.status === 200 && response.data.signedTransactionInfo) {
                await verifyAppleJWS(response.data.signedTransactionInfo);

                await strapi.entityService.update('api::apple-receipt.apple-receipt', receipt.id, {
                    data: { status: 'verified' },
                });
                logger.info(`[CRON JOB] SUCCESS: Verified transaction ${receipt.transactionId}.`);
            }
        } catch (error) {
            if (error.response && error.response.status === 404) {
                logger.warn(`[CRON JOB] INFO: Transaction ${receipt.transactionId} still not found (404). Will retry on next run.`);
            } else {
                logger.error(`[CRON JOB] FAILED: Unrecoverable error for transaction ${receipt.transactionId}.`, error.message);
                await strapi.entityService.update('api::apple-receipt.apple-receipt', receipt.id, {
                    data: { status: 'failed_verification' },
                });
            }
        }
    }
    logger.info('[CRON JOB] Finished: doubleCheckAppleReceipts run complete.');
};


module.exports = {
  doubleCheckAppleReceipts,
};