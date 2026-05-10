'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const createDatabaseConfig = require('../config/database');

const createEnv = (values = {}) => {
  const env = (name, defaultValue) => (name in values ? values[name] : defaultValue);
  env.int = (name, defaultValue) => {
    if (!(name in values)) return defaultValue;
    return Number.parseInt(values[name], 10);
  };
  env.bool = (name, defaultValue) => {
    if (!(name in values)) return defaultValue;
    const value = values[name];
    if (typeof value === 'boolean') return value;
    return value === 'true';
  };
  return env;
};

test('postgres database config uses Cloud-SQL-safe keepalive and idle pool defaults', () => {
  const config = createDatabaseConfig({
    env: createEnv({
      DATABASE_CLIENT: 'postgres',
    }),
  });

  assert.equal(config.connection.client, 'postgres');
  assert.equal(config.connection.connection.keepAlive, true);
  assert.equal(config.connection.connection.keepAliveInitialDelayMillis, 10000);
  assert.equal(config.connection.pool.min, 0);
  assert.equal(config.connection.pool.max, 10);
  assert.equal(config.connection.pool.idleTimeoutMillis, 30000);
  assert.equal(config.connection.pool.reapIntervalMillis, 1000);
});
