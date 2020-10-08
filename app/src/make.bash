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

if [ ! -f "$TARGET/armeabi-v7a/libspp.so" ] || [ ! -f "$TARGET/arm64-v8a/libspp.so" ] ||
   [ ! -f "$TARGET/x86/libspp.so" ] || [ ! -f "$TARGET/x86_64/libspp.so" ]; then

    echo "Get dependences for spp"
    go get -v

    echo "Cross compile spp for arm"
    if [ ! -f "$TARGET/armeabi-v7a/libspp.so" ]; then
        try env CGO_ENABLED=1 CC=$TOOLCHAIN/armv7a-linux-androideabi${MIN_API}-clang GOOS=android GOARCH=arm GOARM=7 go build -ldflags="-s -w"
        try $TOOLCHAIN/arm-linux-androideabi-strip client
        try mv client $TARGET/armeabi-v7a/libspp.so
    fi

    echo "Cross compile spp for arm64"
    if [ ! -f "$TARGET/arm64-v8a/libspp.so" ]; then
        try env CGO_ENABLED=1 CC=$TOOLCHAIN/aarch64-linux-android${MIN_API}-clang GOOS=android GOARCH=arm64 go build -ldflags="-s -w"
        try $TOOLCHAIN/aarch64-linux-android-strip client
        try mv client $TARGET/arm64-v8a/libspp.so
    fi

    echo "Cross compile spp for 386"
    if [ ! -f "$TARGET/x86/libspp.so" ]; then
        try env CGO_ENABLED=1 CC=$TOOLCHAIN/i686-linux-android${MIN_API}-clang GOOS=android GOARCH=386 go build -ldflags="-s -w"
        try $TOOLCHAIN/i686-linux-android-strip client
        try mv client $TARGET/x86/libspp.so
    fi

    echo "Cross compile spp for amd64"
    if [ ! -f "$TARGET/x86_64/libspp.so" ]; then
        try env CGO_ENABLED=1 CC=$TOOLCHAIN/x86_64-linux-android${MIN_API}-clang GOOS=android GOARCH=amd64 go build -ldflags="-s -w"
        try $TOOLCHAIN/x86_64-linux-android-strip client
        try mv client $TARGET/x86_64/libspp.so
    fi

    popd

fi

echo "Successfully build spp"
