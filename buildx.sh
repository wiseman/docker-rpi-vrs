#!/bin/sh

IMAGE=mikenye/virtualradarserver

docker context use x86_64
export DOCKER_CLI_EXPERIMENTAL="enabled"
docker buildx use homecluster

# Build the image using buildx
docker buildx build -t ${IMAGE}:latest --compress --push --platform linux/amd64,linux/arm/v7,linux/arm64 .
docker pull ${IMAGE}:latest

# Starting container to pull version from container logs
VERSION=`docker run --rm --name get_vrs_version --entrypoint cat ${IMAGE}:latest /VERSION`
# Tag the freshly built image
echo ""
echo VirtualRadarServer version ${VERSION} found
echo ""
docker buildx build -t ${IMAGE}:${VERSION} --compress --push --platform linux/amd64,linux/arm/v7,linux/arm64 .
