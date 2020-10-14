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
* clone代码
```
# git clone https://github.com/esrrhs/spp-shadowsocks-plugin-android.git
# cd spp-shadowsocks-plugin-android
```
* 编译
```
# docker run --rm -u root -v ${PWD}:/build -w /build shadowsocks/android-ndk-go ./gradlew assembleDebug
```
* 查看运行日志，需要下载[platform-tools](https://developer.android.com/studio/releases/platform-tools)
```
# adb.exe logcat -s spp
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
