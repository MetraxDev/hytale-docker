#!/usr/bin/env sh

./hytale-downloader-linux-amd64 -version

./hytale-downloader-linux-amd64 -print-version
version=$(./hytale-downloader-linux-amd64 -print-version)

if [ ! -d "$version" ]
then
    ./hytale-downloader-linux-amd64
    unzip $version -d /data/$version
fi

cd /data/$version

java -jar "Server/HytaleServer.jar" --assets "Assets.zip"