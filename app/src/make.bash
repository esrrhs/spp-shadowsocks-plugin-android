#!/bin/bash

function try () {
"$@" || exit -1
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TARGET=$DIR/bin

try mkdir -p $TARGET/armeabi-v7a $TARGET/x86 $TARGET/arm64-v8a $TARGET/x86_64

if [ ! -f "$TARGET/armeabi-v7a/libspp.so" ] || [ ! -f "$TARGET/arm64-v8a/libspp.so" ] ||
   [ ! -f "$TARGET/x86/libspp.so" ] || [ ! -f "$TARGET/x86_64/libspp.so" ]; then

    echo "Cross compile spp for arm"
    if [ ! -f "$TARGET/armeabi-v7a/libspp.so" ]; then
        try cp $DIR/spp/spp-shadowsocks-plugin_android_arm7/spp-shadowsocks-plugin $TARGET/armeabi-v7a/libspp.so
    fi

    echo "Cross compile spp for arm64"
    if [ ! -f "$TARGET/arm64-v8a/libspp.so" ]; then
        try cp $DIR/spp/spp-shadowsocks-plugin_android_arm64/spp-shadowsocks-plugin $TARGET/arm64-v8a/libspp.so
    fi

    echo "Cross compile spp for 386"
    if [ ! -f "$TARGET/x86/libspp.so" ]; then
        try cp $DIR/spp/spp-shadowsocks-plugin_android_386/spp-shadowsocks-plugin $TARGET/x86/libspp.so
    fi

    echo "Cross compile spp for amd64"
    if [ ! -f "$TARGET/x86_64/libspp.so" ]; then
        try cp $DIR/spp/spp-shadowsocks-plugin_android_amd64/spp-shadowsocks-plugin $TARGET/x86_64/libspp.so
    fi

fi

echo "Successfully build spp"
