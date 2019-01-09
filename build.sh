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

mkdir -p vrsbuild
for file in $FILES
do
    download_if_newer "$file.$EXT" "$BASE_URL/$file.$EXT"
    (cd vrsbuild && tar xzvf "../$file.$EXT")
done

download_if_newer VirtualRadar.exe.config.tar.gz "$BASE_URL/VirtualRadar.exe.config.tar.gz"
(cd vrsbuild && tar xvf ../VirtualRadar.exe.config.tar.gz)

mkdir -p vrsbuild/logos
(cd vrsbuild/logos && tar xzvf ../../logos.tar.gz)
mkdir -p vrsbuild/sideviews
(cd vrsbuild/sideviews && tar xzvf ../../sideviews.tar.gz)

docker build -t lemondronor/rpi-vrs .
#rm -rf vrsbuild
