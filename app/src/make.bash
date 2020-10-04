#!/bin/bash

function try () {
"$@" || exit -1
}

[ -z "$ANDROID_NDK_HOME" ] && ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle
TOOLCHAIN=$(find $ANDROID_NDK_HOME/toolchains/llvm/prebuilt/* -maxdepth 1 -type d -print -quit)/bin

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MIN_API=$1
TARGET=$DIR/bin

try mkdir -p $TARGET/armeabi-v7a $TARGET/x86 $TARGET/arm64-v8a $TARGET/x86_64

export GOPATH=$DIR

pushd $DIR/spp/client

echo "Successfully build spp"
