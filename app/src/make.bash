#!/bin/bash

function try () {
"$@" || exit -1
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TARGET=$DIR/bin

try mkdir -p $TARGET/armeabi-v7a $TARGET/x86 $TARGET/arm64-v8a $TARGET/x86_64

try cp $DIR/spp/spp-shadowsocks-plugin_android_arm7/spp-shadowsocks-plugin $TARGET/armeabi-v7a/libspp.so

try cp $DIR/spp/spp-shadowsocks-plugin_android_arm64/spp-shadowsocks-plugin $TARGET/arm64-v8a/libspp.so

try cp $DIR/spp/spp-shadowsocks-plugin_android_386/spp-shadowsocks-plugin $TARGET/x86/libspp.so

try cp $DIR/spp/spp-shadowsocks-plugin_android_amd64/spp-shadowsocks-plugin $TARGET/x86_64/libspp.so

echo "Successfully build spp"
