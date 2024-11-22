#!/bin/bash

# Define the image name
IMAGE_NAME="ohrafaelmartins/elixirdemo"

echo "Building Docker image with commit hash: ${GITHUB_SHA}"

# Create a builder if it doesn't exist (only once)
docker buildx create --use || true

# Build the Docker image with caching and tagging
docker buildx build \
  --cache-from=type=registry,ref=${IMAGE_NAME}:latest \
  --cache-from=type=registry,ref=${IMAGE_NAME}:${COMMIT_HASH} \
  --tag ${IMAGE_NAME}:${COMMIT_HASH} \
  --tag ${IMAGE_NAME}:latest \
  --push .

echo "Docker image built and pushed successfully"