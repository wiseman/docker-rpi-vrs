#!/bin/bash
set -e

download_if_newer() {
    echo "getting $1"
    if [ -e "$1" ]
    then
	curl -o "$1" -z "$1" "$2"
    else
	curl -o "$1" "$2"
    fi
}

FILES="VirtualRadar VirtualRadar.LanguagePack VirtualRadar.WebAdminPlugin VirtualRadar.WebAdminPlugin VirtualRadar.DatabaseWriterPlugin VirtualRadar.CustomContentPlugin VirtualRadar.DatabaseEditorPlugin"
EXT=tar.gz
BASE_URL="http://www.virtualradarserver.co.uk/Files"
BUILD_DIR=build

mkdir -p $BUILD_DIR/vrs

for file in $FILES
do
    download_if_newer "$BUILD_DIR/$file.$EXT" "$BASE_URL/$file.$EXT"
    (cd $BUILD_DIR/vrs && tar xzvf "../$file.$EXT")
done

download_if_newer $BUILD_DIR/VirtualRadar.exe.config.tar.gz "$BASE_URL/VirtualRadar.exe.config.tar.gz"
(cd $BUILD_DIR/vrs && tar xvf ../VirtualRadar.exe.config.tar.gz)

mkdir -p $BUILD_DIR/logos
(cd $BUILD_DIR/logos && tar xzvf ../../logos.tar.gz)
mkdir -p $BUILD_DIR/silhouettes
(cd $BUILD_DIR/silhouettes && tar xzvf ../../silhouettes.tar.gz)

docker build -t lemondronor/rpi-vrs .
