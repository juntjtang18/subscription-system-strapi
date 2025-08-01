# Load environment variables from .env.langgo
if [ -f .env.langgo ]; then
    echo "--- Loading environment variables from .env.langgo ---"
    set -o allexport
    source .env.langgo
    set +o allexport
else
    echo "Error: .env.langgo file not found. Please create it with required variables."
    exit 1
fi

echo "--- Verifying loaded environment variables ---"
echo "DATABASE_CLIENT=$DATABASE_CLIENT"
echo "DATABASE_NAME=$DATABASE_NAME"
echo "DATABASE_USERNAME=$DATABASE_USERNAME"
echo "DATABASE_PASSWORD=$DATABASE_PASSWORD"
echo "CLOUD_SQL_INSTANCE=$CLOUD_SQL_INSTANCE"
echo "APP_URL=$APP_URL"
echo "ADMIN_URL=$ADMIN_URL"
echo "APP_KEYS=$APP_KEYS"
echo "API_TOKEN_SALT=$API_TOKEN_SALT"
echo "ADMIN_JWT_SECRET=$ADMIN_JWT_SECRET"
echo "JWT_SECRET=$JWT_SECRET"
echo "TRANSFER_TOKEN_SALT=$TRANSFER_TOKEN_SALT"
echo "OPENAI_API_KEY=$OPENAI_API_KEY"
echo "APPLE_ISSUER_ID=$APPLE_ISSUER_ID"
echo "APPLE_KEY_ID=$APPLE_KEY_ID"
echo "APPLE_BUNDLE_ID=$APPLE_BUNDLE_ID"
echo "APPLE_PRIVATE_KEY=$APPLE_PRIVATE_KEY"
echo "APPLE_ENVIRONMENT=$APPLE_ENVIRONMENT"
echo "APPLE_CONNECT_MOCK=$APPLE_CONNECT_MOCK"
echo "LOG_LEVEL=$LOG_LEVEL"
echo "APPLE_API_VERSION=$APPLE_API_VERSION"
echo "--- Done verifying ---"
