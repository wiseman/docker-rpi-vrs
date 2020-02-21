#!/bin/sh

# Get build system architecture
ARCH=`uname -m`

# Make architecture names match s6 overlay architecture names
if [ ${ARCH} = "aarch64" ]; then
    ARCH_S6OVERLAY="aarch64"
elif [ ${ARCH} = "x86_64" ]; then
    ARCH_S6OVERLAY="amd64"
elif [ ${ARCH} = "armv7l" ]; then
    ARCH_S6OVERLAY="armhf"
else
    echo "Unknown architecture"
    exit 1
fi

# Download S6 Overlay
echo Getting s6-overlay from: https://github.com/just-containers/s6-overlay/releases/download/${VERSION_S6OVERLAY}/s6-overlay-${ARCH_S6OVERLAY}.tar.gz
curl --location --output /tmp/s6-overlay.tar.gz https://github.com/just-containers/s6-overlay/releases/download/${VERSION_S6OVERLAY}/s6-overlay-${ARCH_S6OVERLAY}.tar.gz

