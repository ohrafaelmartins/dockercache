#!/bin/bash
set -e

COMMIT_HASH=$1
IMAGE_NAME="ohrafaelmartins/elixirdemo"

# Enable Docker BuildKit for better caching
export DOCKER_BUILDKIT=1

# Build the Docker image with caching
docker build \
  --cache-from=${IMAGE_NAME}:latest \
  --cache-from=${IMAGE_NAME}:${COMMIT_HASH} \
  --tag ${IMAGE_NAME}:${COMMIT_HASH} \
  --tag ${IMAGE_NAME}:latest \
  .

echo "Docker image ${IMAGE_NAME}:${COMMIT_HASH} built successfully."
