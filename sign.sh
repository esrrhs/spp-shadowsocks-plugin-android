#! /bin/sh

/home/project/android/build-tools/34.0.0/apksigner  sign --ks my-release-key.jks --out app-armeabi-v7a-release-signed.apk ./app/build/outputs/apk/release/app-armeabi-v7a-release-unsigned.apk

/home/project/android/build-tools/34.0.0/apksigner  sign --ks my-release-key.jks --out app-arm64-v8a-release-signed.apk ./app/build/outputs/apk/release/app-arm64-v8a-release-unsigned.apk

/home/project/android/build-tools/34.0.0/apksigner  sign --ks my-release-key.jks --out app-x86_64-release-signed.apk ./app/build/outputs/apk/release/app-x86_64-release-unsigned.apk

/home/project/android/build-tools/34.0.0/apksigner  sign --ks my-release-key.jks --out app-x86-release-signed.apk ./app/build/outputs/apk/release/app-x86-release-unsigned.apk

/home/project/android/build-tools/34.0.0/apksigner  sign --ks my-release-key.jks --out app-universal-release-signed.apk ./app/build/outputs/apk/release/app-universal-release-unsigned.apk

