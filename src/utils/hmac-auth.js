'use strict';

const crypto = require('crypto');
const { ApplicationError } = require('@strapi/utils').errors;

const DEFAULT_WINDOW_SECONDS = 5 * 60;

function canonicalJson(value) {
  if (value === null || value === undefined) return '';
  if (Array.isArray(value)) return `[${value.map(canonicalJson).join(',')}]`;
  if (typeof value === 'object') {
    return `{${Object.keys(value).sort().map((key) => `${JSON.stringify(key)}:${canonicalJson(value[key])}`).join(',')}}`;
  }
  return JSON.stringify(value);
}

function buildSignaturePayload(ctx, timestamp) {
  const method = ctx.request.method.toUpperCase();
  const path = ctx.request.url; // includes query string
  const body = canonicalJson(ctx.request.body || null);
  return `${method}\n${path}\n${timestamp}\n${body}`;
}

function verifyInternalHmac(ctx) {
  const secret = process.env.UM_INTERNAL_SECRET;
  if (!secret) {
    throw new ApplicationError('UM_INTERNAL_SECRET is not configured.');
  }

  const timestamp = ctx.request.headers['x-um-timestamp'];
  const signature = ctx.request.headers['x-um-signature'];
  if (!timestamp || !signature) {
    ctx.throw(401, 'Missing internal usage signature.');
  }

  const timestampNumber = Number(timestamp);
  if (!Number.isFinite(timestampNumber)) {
    ctx.throw(401, 'Invalid internal usage timestamp.');
  }

  const now = Math.floor(Date.now() / 1000);
  const allowedWindow = Number(process.env.UM_SIGNATURE_WINDOW_SECONDS || DEFAULT_WINDOW_SECONDS);
  if (Math.abs(now - timestampNumber) > allowedWindow) {
    ctx.throw(401, 'Expired internal usage signature.');
  }

  const payload = buildSignaturePayload(ctx, timestamp);
  const expected = crypto.createHmac('sha256', secret).update(payload).digest('hex');

  const expectedBuffer = Buffer.from(expected, 'hex');
  const receivedBuffer = Buffer.from(String(signature), 'hex');
  if (receivedBuffer.length !== expectedBuffer.length || !crypto.timingSafeEqual(receivedBuffer, expectedBuffer)) {
    ctx.throw(401, 'Invalid internal usage signature.');
  }
}

module.exports = {
  canonicalJson,
  buildSignaturePayload,
  verifyInternalHmac,
};
