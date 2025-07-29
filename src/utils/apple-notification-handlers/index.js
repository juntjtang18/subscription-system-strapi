"use strict";

const SUBSCRIBED = require("./subscribed");
const DID_RENEW = require("./didRenew");
const EXPIRED = require("./expired");
const DID_FAIL_TO_RENEW = require("./didFailToRenew");
const DID_CHANGE_RENEWAL_STATUS = require("./didChangeRenewalStatus");
const DID_CHANGE_RENEWAL_PREF = require("./didChangeRenewalPref");
const REFUND = require("./refund");
const REVOKE = require("./revoke");
const OFFER_REDEEMED = require("./offerRedeemed");
const PRICE_INCREASE = require("./priceIncrease");
const TEST = require("./test");

module.exports = {
  SUBSCRIBED,
  DID_RENEW,
  EXPIRED,
  DID_FAIL_TO_RENEW,
  DID_CHANGE_RENEWAL_STATUS,
  DID_CHANGE_RENEWAL_PREF,
  REFUND,
  REVOKE,
  OFFER_REDEEMED,
  PRICE_INCREASE,
  TEST,
};