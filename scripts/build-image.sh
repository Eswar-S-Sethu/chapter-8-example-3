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

# Use docker buildx build if you want to build the image for multiple platforms
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t "${CONTAINER_REGISTRY}/video-streaming:${VERSION}" \
  --file ./Dockerfile-prod \
  .

# If you are not using buildx and want to push the image to your registry:
# docker push "${CONTAINER_REGISTRY}/video-streaming:${VERSION}"
