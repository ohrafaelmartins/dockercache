#!/bin/bash

# Define the image name (set explicitly)
IMAGE_NAME="ohrafaelmartins/elixirdemo"

# Ensure GITHUB_SHA is set (from the GitHub Actions environment)
if [ -z "${GITHUB_SHA}" ]; then
  echo "Error: GITHUB_SHA is not set"
  exit 1
fi

echo "Building Docker image with commit hash: ${GITHUB_SHA}"

# Create a builder if it doesn't exist (only once)
docker buildx create --use || true

# Build the Docker image with caching and tagging
docker buildx build \
  --cache-from=type=registry,ref=${IMAGE_NAME}:latest \
  --cache-from=type=registry,ref=${IMAGE_NAME}:${GITHUB_SHA} \
  --tag ${IMAGE_NAME}:${GITHUB_SHA} \
  --tag ${IMAGE_NAME}:latest . \
  --push .