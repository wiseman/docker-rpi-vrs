#!/bin/sh

ARCH=`uname -m`
IMAGE=mikenye/virtualradarserver

# Build
echo Building ${IMAGE}:builder-${ARCH}
docker build -t ${IMAGE}:builder-${ARCH} .

# Get version from just-built container
# Starting container to pull version from container logs
VERSION=`timeout 5 docker run --rm --name get_vrs_version --entrypoint cat ${IMAGE}:builder-${ARCH} /VERSION`
# Tag the freshly built image
echo VirtualRadarServer version ${VERSION} found
echo Tagging ${IMAGE}:builder-${ARCH} as ${IMAGE}:${VERSION}-${ARCH}
docker tag ${IMAGE}:builder-${ARCH} ${IMAGE}:${VERSION}-${ARCH}
# Kill the temporary container if its still running (timeout will kill it automatically after 5 seconds in case this script dies)
docker kill get_vrs_version > /dev/null 2>&1
# Clean up the builder container
docker image rm ${IMAGE}:builder-${ARCH} > /dev/null 2>&1

