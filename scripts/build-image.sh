#!/bin/bash

#
# Builds a Docker image.
#
# Environment variables:
#
#   CONTAINER_REGISTRY - The hostname of your container registry.
#   VERSION - The version number to tag the images with.
#
# Usage:
#
#       ./scripts/build-image.sh
#

set -u # or set -o nounset
: "${CONTAINER_REGISTRY:?CONTAINER_REGISTRY is unset or empty}"
: "${VERSION:?VERSION is unset or empty}"

# Build the Docker image
docker buildx build \
  --platform linux/amd64 \
  -t "${CONTAINER_REGISTRY}/video-streaming:${VERSION}" \
  --file ./Dockerfile-prod \
  .

# Push the image to Azure Container Registry
docker push "${CONTAINER_REGISTRY}/video-streaming:${VERSION}"
