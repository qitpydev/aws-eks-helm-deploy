#!/bin/bash

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --aws-access-key-id) AWS_ACCESS_KEY_ID="$2"; shift ;;
    --aws-secret-access-key) AWS_SECRET_ACCESS_KEY="$2"; shift ;;
    --aws-default-region) AWS_DEFAULT_REGION="$2"; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
  shift
done

# Validate that AWS_ACCESS_KEY_ID is a non-empty string
if [ -z "${AWS_ACCESS_KEY_ID}" ]; then
  echo "AWS_ACCESS_KEY_ID is not set or is an empty string"
  exit 1
fi

# Validate that AWS_SECRET_ACCESS_KEY is a non-empty string
if [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
  echo "AWS_SECRET_ACCESS_KEY is not set or is an empty string"
  exit 1
fi

# Validate that AWS_DEFAULT_REGION is a non-empty string
if [ -z "${AWS_DEFAULT_REGION}" ]; then
  echo "AWS_DEFAULT_REGION is not set or is an empty string"
  exit 1
fi

# If all variables are set and non-empty strings, print their values
echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
echo "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
echo "AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}"
