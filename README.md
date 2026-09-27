# spp-shadowsocks-plugin-android

[<img src="https://img.shields.io/github/license/esrrhs/spp-shadowsocks-plugin-android">](https://github.com/esrrhs/spp-shadowsocks-plugin-android)
[<img src="https://img.shields.io/github/languages/top/esrrhs/spp-shadowsocks-plugin-android">](https://github.com/esrrhs/spp-shadowsocks-plugin-android)
[<img src="https://img.shields.io/github/v/release/esrrhs/spp-shadowsocks-plugin-android">](https://github.com/esrrhs/spp-shadowsocks-plugin-android/releases)
[<img src="https://img.shields.io/github/downloads/esrrhs/spp-shadowsocks-plugin-android/total">](https://github.com/esrrhs/spp-shadowsocks-plugin-android/releases)

[spp](https://github.com/esrrhs/spp)针对shadowsocks android的插件，依赖[spp-shadowsocks-plugin](https://github.com/esrrhs/spp-shadowsocks-plugin)

<a href="https://play.google.com/store/apps/details?id=com.github.shadowsocks.plugin.spp"><img src="https://play.google.com/intl/en_us/badges/images/generic/en-play-badge.png" height="48"></a>
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

# 特性
* 基于 [spp-shadowsocks-plugin](https://github.com/esrrhs/spp-shadowsocks-plugin) v0.8.0 / [spp](https://github.com/esrrhs/spp) 最新版本
* 支持协议 tcp、kcp、quic，自定义协议 rudp、rhttp、ricmp（非 root 手机不支持 ricmp）
* 鉴权 `key` 必填；整帧加密 `encrypt` 默认关闭，可按需开启
* 支持压缩，默认关闭

# 编译
* 准备环境
* 安装java
```
# dnf install java-17-openjdk-devel
# sudo alternatives --config java
# java -version
# readlink -f $(which java)
# export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
# export PATH=$JAVA_HOME/bin:$PATH
```
* 安装SDK
```
# mkdir -p ~/android-sdk/cmdline-tools
# cd ~/android-sdk/cmdline-tools
# wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
# unzip commandlinetools-linux-11076708_latest.zip
# mv cmdline-tools latest
# mkdir -p ~/android-sdk/cmdline-tools/latest
# export ANDROID_HOME=$HOME/android-sdk
# export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH
# yes | sdkmanager --licenses
# sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.1.0"
```
* 安装NDK
```
# sdkmanager "ndk;29.0.14206865"
# export ANDROID_NDK_HOME=/root/android-sdk/ndk/29.0.14206865
# export PATH=$ANDROID_NDK_HOME:$PATH
```

* clone代码
```
# git clone https://github.com/esrrhs/spp-shadowsocks-plugin-android.git
# cd spp-shadowsocks-plugin-android
```
* 编译
```
./gradlew clean assembleRelease
```

# 使用
* 安装shadowsocks android，Google Play或者[地址](https://github.com/shadowsocks/shadowsocks-android)
* 安装spp插件，Google Play或者[地址](https://github.com/esrrhs/spp-shadowsocks-plugin-android/releases)
* 在shadowsocks插件里，选择spp
* 配置至少填写 `key`（与服务器一致）和 `proto`。更多参数点击?，或直接访问[spp](https://github.com/esrrhs/spp) / [spp-shadowsocks-plugin](https://github.com/esrrhs/spp-shadowsocks-plugin)
```
proto=rudp;key=your-auth-key
```
* shadowsocks 服务器侧同样需要配置相同的 `key` / `proto`，参考 [spp-shadowsocks-plugin](https://github.com/esrrhs/spp-shadowsocks-plugin)

# 故障排除
* Q：无法启动，点击报错
* A：检查是否配置了非空且足够强的 `key`（不能为空，也不能用 `123456`/`password` 等弱密钥），以及其它 spp 参数是否正确

* Q：启动正常，连不上网
* A：先确认不带 spp 能否连通；再核对服务器与客户端的 `key`、`proto`（以及如有配置的 `encrypt`）是否一致
