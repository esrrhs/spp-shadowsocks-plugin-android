#!/bin/bash

function try () {
"$@" || exit -1
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MIN_API=$1
TARGET=$DIR/bin

try mkdir -p $TARGET/armeabi-v7a $TARGET/arm64-v8a

try cp $DIR/spp/spp_arm_7 $TARGET/armeabi-v7a/libspp.so
try cp $DIR/spp/spp_android_arm64 $TARGET/arm64-v8a/libspp.so

echo "Successfully build spp"
