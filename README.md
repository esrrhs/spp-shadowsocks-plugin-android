# spp-shadowsocks-plugin-android

[<img src="https://img.shields.io/github/license/esrrhs/spp-shadowsocks-plugin-android">](https://github.com/esrrhs/spp-shadowsocks-plugin-android)
[<img src="https://img.shields.io/github/languages/top/esrrhs/spp-shadowsocks-plugin-android">](https://github.com/esrrhs/spp-shadowsocks-plugin-android)
[<img src="https://img.shields.io/github/v/release/esrrhs/spp-shadowsocks-plugin-android">](https://github.com/esrrhs/spp-shadowsocks-plugin-android/releases)
[<img src="https://img.shields.io/github/downloads/esrrhs/spp-shadowsocks-plugin-android/total">](https://github.com/esrrhs/spp-shadowsocks-plugin-android/releases)

A [SIP003](https://shadowsocks.org/doc/sip003.html) compliant plugin for [Shadowsocks Android](https://github.com/shadowsocks/shadowsocks-android), powered by [spp-shadowsocks-plugin](https://github.com/esrrhs/spp-shadowsocks-plugin) and [SPP](https://github.com/esrrhs/spp).

<a href="https://play.google.com/store/apps/details?id=com.github.shadowsocks.plugin.spp"><img alt="Get it on Google Play" src="https://play.google.com/intl/en_us/badges/images/generic/en-play-badge.png" height="48"></a>

```
     +------------+                    +---------------------------+
     |  SS Client +-- Local Loopback --+  Plugin Client (Tunnel)   +--+
     +------------+                    +---------------------------+  |
                                                                      |
                 Public Internet (Obfuscated/Transformed traffic) ==> |
                                                                      |
     +------------+                    +---------------------------+  |
     |  SS Server +-- Local Loopback --+  Plugin Server (Tunnel)   +--+
     +------------+                    +---------------------------+
```

---

## Features

* **Latest SPP Core**: Powered by bundled [spp-shadowsocks-plugin](https://github.com/esrrhs/spp-shadowsocks-plugin) v0.8.1 with the latest [SPP](https://github.com/esrrhs/spp) engine.
* **Versatile Underlay Protocols**: Supports standard `tcp`, `kcp`, `quic`, as well as reliable custom protocols `rudp`, `rhttp`, and `ricmp` (*ricmp requires root privileges on Android*).
* **Robust Authentication**: Mandatory pre-shared `key` challenge-response authentication prevents unauthorized probing.
* **Optional Encryption & Compression**: Seamlessly integrate data compression (`compress`) and full-frame encryption (`encrypt`) under the transport layer (disabled by default).
* **Modern Android Standards**: Targets Android 16 (API 36), supports `minSdkVersion 24`, and is fully compliant with Google Play 16KB ELF page alignment requirements.
* **Multi-Architecture Support**: Built for `arm64-v8a`, `armeabi-v7a`, `x86`, and `x86_64`.

---

## Installation

### Google Play
Install directly from [Google Play](https://play.google.com/store/apps/details?id=com.github.shadowsocks.plugin.spp).

### GitHub Releases
Pre-compiled APKs (split by ABI and universal) and Android App Bundles (AAB) are available on [GitHub Releases](https://github.com/esrrhs/spp-shadowsocks-plugin-android/releases).

---

## Usage

1. **Install Shadowsocks Android**: Download from [Google Play](https://play.google.com/store/apps/details?id=com.github.shadowsocks) or [GitHub](https://github.com/shadowsocks/shadowsocks-android/releases).
2. **Install SPP Plugin**: Install this plugin via Google Play or GitHub Releases.
3. **Configure Profile**:
   - Open Shadowsocks Android and select or create a profile.
   - Scroll to **Plugin** and select **spp**.
   - In **Plugin configuration**, enter your desired settings (e.g. `proto=rudp;key=your-auth-key`).
4. **Server Configuration**:
   Ensure the remote Shadowsocks server is configured with [spp-shadowsocks-plugin](https://github.com/esrrhs/spp-shadowsocks-plugin) using the matching `proto`, `key`, and options.

### Common Plugin Options

Options are formatted as a semicolon-separated `key=value` string:

| Option | Type | Default | Description |
|---|---|---|---|
| `proto` | string | `tcp` | Transport protocol: `tcp`, `rudp`, `ricmp`, `rhttp`, `kcp`, `quic` |
| `key` | string | *required* | Pre-shared authentication key (must match the server) |
| `encrypt` | string | *(empty)* | Optional encryption algorithm (e.g. `aes-128`, `aes-256`, `chacha20`) |
| `compress` | int | `0` | Compression level: `0` (disabled) or `1` (enabled) |
| `pinginter` | int | `10` | Heartbeat interval (seconds) |
| `maxmsgsize`| int | `10240` | Maximum message buffer size |

Example configuration:
```
proto=rudp;key=MySecretKey1234
```

---

## Building from Source

### Prerequisites

* **Java**: OpenJDK 17 (`JAVA_HOME` configured)
* **Android SDK**: `platforms;android-36`, `build-tools;36.1.0`
* **Android NDK**: `ndk;29.0.14206865` (`ANDROID_NDK_HOME` configured)
* **Go**: 1.26+ (if recompiling native binaries)

### Build Steps

```bash
# Clone the repository
git clone https://github.com/esrrhs/spp-shadowsocks-plugin-android.git
cd spp-shadowsocks-plugin-android

# Build release APKs (ABI splits + universal)
./gradlew clean assembleRelease

# Build release App Bundle (AAB for Google Play)
./gradlew bundleRelease
```

Build outputs will be generated in:
* APKs: `app/build/outputs/apk/release/`
* Bundle: `app/build/outputs/bundle/release/app-release.aab`

---

## Troubleshooting

* **Plugin fails to start / crashes on connect**:
  - Verify that `key` is configured and is not empty or overly simple (e.g. `123456`, `password`).
  - Verify that the protocol specified in `proto` is supported by your device and server (`ricmp` is not supported without root).
* **Connected but cannot reach the internet**:
  - First test whether the Shadowsocks server works without the plugin.
  - Verify that `key`, `proto`, and `encrypt` (if enabled) match identically between the Shadowsocks client and server plugin configuration.
  - Check Shadowsocks and plugin logcat for detailed error outputs.

---

## License

This project is licensed under the GPLv3 License. See [LICENSE](LICENSE) for details.
