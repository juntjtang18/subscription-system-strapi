// src/utils/apple-jws-verifier.js
"use strict";

const jose = require("node-jose");
const logger = require("./logger");

async function verifyAppleJWS(token) {
  try {
    const headerB64 = token.split(".")[0];
    const header = JSON.parse(
      Buffer.from(headerB64, "base64url").toString("utf8")
    );
    const certPem = `-----BEGIN CERTIFICATE-----\n${header.x5c[0]}\n-----END CERTIFICATE-----`;
    const key = await jose.JWK.asKey(certPem, "pem");
    const verifier = jose.JWS.createVerify(key);
    const result = await verifier.verify(token);
    return JSON.parse(result.payload.toString());
  } catch (error) {
    logger.error(
      `[Apple JWS Verifier] JWS verification failed: ${error.message}`
    );
    throw new Error(`JWS verification failed.`);
  }
}

module.exports = {
  verifyAppleJWS,
};