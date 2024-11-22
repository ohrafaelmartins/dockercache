#!/bin/bash
set -e

COMMIT_HASH=$1
IMAGE_NAME="ohrafaelmartins/elixirdemo"

# Enable Docker BuildKit
export DOCKER_BUILDKIT=1

# Create a builder if it doesn't exist
docker buildx create --use || true

# Build Docker image with cache from Docker Hub
docker buildx build \
  --cache-from=type=registry,ref=${IMAGE_NAME}:latest \
  --cache-from=type=registry,ref=${IMAGE_NAME}:${COMMIT_HASH} \
  --tag ${IMAGE_NAME}:${COMMIT_HASH} \
  --tag ${IMAGE_NAME}:latest \
  --push .  # Push directly to Docker Hub

echo "Docker image ${IMAGE_NAME}:${COMMIT_HASH} built and pushed successfully."