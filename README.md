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
* 支持协议tcp、kcp、quic，自定义协议rudp、rhttp、ricmp（非root手机不支持）
* 支持加密压缩，默认关闭

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
# sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"
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
* 配置填入proto协议。更多参数点击?，或者直接访问[spp](https://github.com/esrrhs/spp)查看
```
proto=rudp
```
* shadowsocks服务器的配置参考spp-shadowsocks-plugin，[地址](https://github.com/esrrhs/spp-shadowsocks-plugin)

# 故障排除
* Q：无法启动，点击报错
* A：检查spp的配置是否正确
* 
* Q：启动正常，连不上网
* A：首先确定不带spp，是否可以。然后看看spp服务器和客户端的key和proto是否一致
