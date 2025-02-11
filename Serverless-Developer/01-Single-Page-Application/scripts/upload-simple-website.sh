#!/usr/bin/env zsh

# Exit immediately if a command exits with a non-zero status
set -e

SCRIPT_DIR=$(dirname "$0")

# Check if the CloudFront distribution ID is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <cloudfront-distribution-id>"
  exit 1
fi

# Define variables
BUCKET_NAME="sd-01-single-page-application"
DISTRIBUTION_ID="$1"

# Upload index.html and app.js to the S3 bucket
aws s3 cp "$SCRIPT_DIR/assets/index.html" s3://$BUCKET_NAME/
aws s3 cp "$SCRIPT_DIR/assets/app.js" s3://$BUCKET_NAME/

# Invalidate the CloudFront distribution
aws cloudfront create-invalidation --distribution-id "$DISTRIBUTION_ID" --paths "/*"

echo "Upload and invalidation complete."
