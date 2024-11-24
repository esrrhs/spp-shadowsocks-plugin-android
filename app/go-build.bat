@echo off

echo Building Go app...
:: from param 1
set MIN_API=%1
echo "MIN_API: %MIN_API%"
echo "ANDROID_HOME: %ANDROID_HOME%"
echo "ANDROID_NDK_HOME: %ANDROID_NDK_HOME%"

set TOOLCHAIN=%ANDROID_NDK_HOME%\toolchains\llvm\prebuilt\windows-x86_64\bin
echo "TOOLCHAIN: %TOOLCHAIN%"

set ROOT=%~dp0
echo "ROOT: %ROOT%"

set OUT_DIR=%ROOT%\build\go
echo "OUT_DIR: %OUT_DIR%"

cd %ROOT%\src\main\go\spp-shadowsocks-plugin
echo "Building spp-shadowsocks-plugin..."

go mod tidy

:: CLANG_ARCHS: armv7a-linux-androideabi aarch64-linux-android i686-linux-android x86_64-linux-android
:: GO_ARCHS: 'arm GOARM=7' arm64 386 amd64

set CGO_ENABLED=1
set GOOS=android

:: armv7a-linux-androideabi
set CC=%TOOLCHAIN%\armv7a-linux-androideabi%MIN_API%-clang
set GOARCH=arm
set GOARM=7
go build -v -ldflags="-s -w" -o "%OUT_DIR%/unstripped"
%TOOLCHAIN%\llvm-strip "%OUT_DIR%/unstripped" -o "%OUT_DIR%\armeabi-v7a\libspp.so"
del "%OUT_DIR%\unstripped"
echo "armv7a-linux-androideabi done"

:: aarch64-linux-android
set CC=%TOOLCHAIN%\aarch64-linux-android%MIN_API%-clang
set GOARCH=arm64
go build -v -ldflags="-s -w" -o "%OUT_DIR%/unstripped"
%TOOLCHAIN%\llvm-strip "%OUT_DIR%/unstripped" -o "%OUT_DIR%\arm64-v8a\libspp.so"
del "%OUT_DIR%\unstripped"
echo "aarch64-linux-android done"

:: i686-linux-android
set CC=%TOOLCHAIN%\i686-linux-android%MIN_API%-clang
set GOARCH=386
go build -v -ldflags="-s -w" -o "%OUT_DIR%/unstripped"
%TOOLCHAIN%\llvm-strip "%OUT_DIR%/unstripped" -o "%OUT_DIR%\x86\libspp.so"
del "%OUT_DIR%\unstripped"
echo "i686-linux-android done"

:: x86_64-linux-android
set CC=%TOOLCHAIN%\x86_64-linux-android%MIN_API%-clang
set GOARCH=amd64
go build -v -ldflags="-s -w" -o "%OUT_DIR%/unstripped"
%TOOLCHAIN%\llvm-strip "%OUT_DIR%/unstripped" -o "%OUT_DIR%\x86_64\libspp.so"
del "%OUT_DIR%\unstripped"
echo "x86_64-linux-android done"

