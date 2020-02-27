#!/bin/sh

VERSION=latest
IMAGE=lemondronor/vrs

docker buildx build -t ${IMAGE}:${VERSION} --compress --push --platform linux/amd64,linux/arm/v7,linux/arm64 .

