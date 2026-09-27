#! /bin/sh
set -e

KS="${KS:-/root/my-release-key.jks}"
KS_PASS_FILE="${KS_PASS_FILE:-/root/pd}"
KS_ALIAS="${KS_ALIAS:-my-alias}"
APKSIGNER="${APKSIGNER:-/root/android-sdk/build-tools/36.1.0/apksigner}"
OUT_DIR="${OUT_DIR:-signed}"
IN_DIR="${IN_DIR:-./app/build/outputs/apk/release}"

if [ ! -f "$KS" ]; then
  echo "keystore not found: $KS" >&2
  exit 1
fi
if [ ! -f "$KS_PASS_FILE" ]; then
  echo "keystore password file not found: $KS_PASS_FILE" >&2
  exit 1
fi

PASS=$(cat "$KS_PASS_FILE")
mkdir -p "$OUT_DIR"

for abi in armeabi-v7a arm64-v8a x86_64 x86 universal; do
  in="$IN_DIR/app-${abi}-release-unsigned.apk"
  out="$OUT_DIR/app-${abi}-release-signed.apk"
  "$APKSIGNER" sign \
    --ks "$KS" \
    --ks-key-alias "$KS_ALIAS" \
    --ks-pass "pass:${PASS}" \
    --key-pass "pass:${PASS}" \
    --out "$out" \
    "$in"
  echo "signed: $out"
done
