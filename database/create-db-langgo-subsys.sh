#!/bin/bash
# Simple script to recreate a PostgreSQL database in Google Cloud SQL
# Assumes the app user already exists
# --- Configuration ---
DB_ADMIN_USER="postgres"
DB_ADMIN_PASSWORD="Passw0rd@P0stgres"
DB_APP_USER="strapi"
DB_NAME="langgo-subsys-db1"
DB_HOST="/cloudsql/lucid-arch-451211-b0:us-west1:cloud-sql-server"

# Drop and recreate the database
PGPASSWORD="$DB_ADMIN_PASSWORD" psql -h "$DB_HOST" -U "$DB_ADMIN_USER" \
  -c "DROP DATABASE IF EXISTS \"$DB_NAME\";"
PGPASSWORD="$DB_ADMIN_PASSWORD" psql -h "$DB_HOST" -U "$DB_ADMIN_USER" \
  -c "CREATE DATABASE \"$DB_NAME\" OWNER \"$DB_APP_USER\";"
# Grant privileges to the existing user
PGPASSWORD="$DB_ADMIN_PASSWORD" psql -h "$DB_HOST" -U "$DB_ADMIN_USER" \
  -c "GRANT ALL PRIVILEGES ON DATABASE \"$DB_NAME\" TO \"$DB_APP_USER\";"

echo "✔️  Database '$DB_NAME' created and privileges granted to '$DB_APP_USER'."