#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Load environment variables from .env
if [ -f .env.gpa ]; then
    source .env.gpa
else
    echo "Error: .env file not found. Please create .env with required variables."
    exit 1
fi

# --- Versioning Configuration ---
# The script will automatically increment the minor version number.
# To reset or change the major version, manually edit the 'VERSION' file.
VERSION_FILE="VERSION"

if [ ! -f "$VERSION_FILE" ]; then
  echo "1.0" > "$VERSION_FILE"
fi

# Read the version, increment the minor number
VERSION=$(awk -F. -v OFS=. '{$NF++;print}' "$VERSION_FILE")
echo "$VERSION" > "$VERSION_FILE"

# --- Configuration ---
PROJECT_ID="lucid-arch-451211-b0"
SERVICE_NAME="gpasubsys"
REGION="us-west1"
IMAGE_NAME="gcr.io/${PROJECT_ID}/${SERVICE_NAME}:${VERSION}"
CLOUD_SQL_INSTANCE="lucid-arch-451211-b0:us-west1:cloud-sql-server"

# --- Deployment Steps ---

echo "--- Deploying version: ${VERSION} ---"

# 1. Build and tag the Docker image
echo "Building Docker image: ${IMAGE_NAME}"
docker build -t "${IMAGE_NAME}" .

# 2. Push the Docker image to Google Container Registry
echo "Pushing Docker image..."
docker push "${IMAGE_NAME}"

# 3. Deploy to Cloud Run
# !!! --- SECURITY WARNING --- !!!
# For production, use Google Secret Manager for sensitive data.
# Learn more: https://cloud.google.com/secret-manager
echo "Deploying to Cloud Run service: ${SERVICE_NAME}"
gcloud run deploy "${SERVICE_NAME}" \
  --image "${IMAGE_NAME}" \
  --platform "managed" \
  --region "${REGION}" \
  --memory "1Gi" \
  --timeout "600" \
  --allow-unauthenticated \
  --add-cloudsql-instances "${CLOUD_SQL_INSTANCE}" \
  --set-env-vars "NODE_ENV=development" \
  --set-env-vars "CLOUD_SQL_INSTANCE=${CLOUD_SQL_INSTANCE}" \
  --set-env-vars "DATABASE_NAME=${DATABASE_NAME}" \
  --set-env-vars "DATABASE_USERNAME=${DATABASE_USERNAME}" \
  --set-env-vars "DATABASE_PASSWORD=${DATABASE_PASSWORD}" \
  --set-env-vars "APP_URL=https://gpasubsys.geniusParentingAI.ca" \
  --set-env-vars "ADMIN_URL=https://gpasubsys.geniusParentingAI.ca/admin" \
  --set-env-vars "APP_KEYS=${APP_KEYS}" \
  --set-env-vars "API_TOKEN_SALT=${API_TOKEN_SALT}" \
  --set-env-vars "ADMIN_JWT_SECRET=${ADMIN_JWT_SECRET}" \
  --set-env-vars "JWT_SECRET=${JWT_SECRET}" \
  --set-env-vars "TRANSFER_TOKEN_SALT=${TRANSFER_TOKEN_SALT}" \
  --set-env-vars "OPENAI_API_KEY=${OPENAI_API_KEY}" \
  --revision-suffix "v${VERSION//./-}"

echo "--- Deployment of ${SERVICE_NAME} version ${VERSION} complete! ---"