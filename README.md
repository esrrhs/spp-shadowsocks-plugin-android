# spp-shadowsocks-plugin-android
[spp](https://github.com/esrrhs/spp)针对shadowsocks android的插件，依赖[spp-shadowsocks-plugin](https://github.com/esrrhs/spp-shadowsocks-plugin)
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

# 编译
* clone代码
```
# git clone https://github.com/esrrhs/spp-shadowsocks-plugin-android.git
# cd spp-shadowsocks-plugin-android
# git submodule update --init --recursive
# chmod a+rwx ./ -R
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
* 安装shadowsocks android，[地址](https://github.com/shadowsocks/shadowsocks-android)
* 安装spp-shadowsocks-plugin-android，[地址](https://github.com/esrrhs/spp-shadowsocks-plugin-android/releases)
* 在shadowsocks插件里，选择spp
* 配置填入proto协议，key密码。更多参数点击?，或者直接访问[spp](https://github.com/esrrhs/spp)查看
```
proto=rudp;key=abcdef
```

# 故障排除
* 无法启动，点击报错
检查spp的配置是否正确

* 启动正常，连不上网
首先确定不带spp，是否可以。然后看看spp服务器和客户端的key和proto是否一致
