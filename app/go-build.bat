@echo off
setlocal

if "%ANDROID_NDK_HOME%"=="" (
    set ANDROID_NDK_HOME="%ANDROID_HOME%\ndk-bundle"
)

for /D %%i in (%ANDROID_NDK_HOME%\toolchains\llvm\prebuilt\*) do (
    set TOOLCHAIN=%%~fi\bin
    goto :found_toolchain
)

:found_toolchain

call echo "TOOLCHAIN is %TOOLCHAIN%"

set "ABIS=armeabi-v7a arm64-v8a x86 x86_64"
set "GO_ARCHS=arm GOARM=7 arm64 386 amd64"
set "CLANG_ARCHS=armv7a-linux-androideabi aarch64-linux-android i686-linux-android x86_64-linux-android"

set MIN_API=%1
set ROOT=%~dp0
set OUT_DIR=%ROOT%build\go

pushd "%ROOT%src\main\go\spp-shadowsocks-plugin"
set BIN=libspp.so

go mod tidy

for %%a in (%ABIS%) do (
    set ABI=%%a
    call echo Building %BIN% %%a
    mkdir "%OUT_DIR%\%%a"
    
    call set "GOARCH=%%a"
    
    %TOOLCHAIN%\%CLANG_ARCHS:~%%~a=%%~a% %MIN_API%-clang
    set "GOOS=android"
    
    go build -v -ldflags="-s -w" -o "%OUT_DIR%\unstripped"
    
    if errorlevel 1 exit /b -1

    %TOOLCHAIN%\llvm-strip "%OUT_DIR%\unstripped" -o "%OUT_DIR%\%%a\%BIN%"
    del "%OUT_DIR%\unstripped"
)

popd
endlocal