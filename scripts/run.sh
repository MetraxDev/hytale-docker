#!/usr/bin/env sh

./hytale-downloader-linux-amd64 -version

./hytale-downloader-linux-amd64 -print-version
version=$(./hytale-downloader-linux-amd64 -print-version)

if [ ! -d "$version" ]
then
    ./hytale-downloader-linux-amd64
    unzip $version -d $version
fi

java -jar "$version/Server/HytaleServer.jar" --assets "$version/Assets.zip"