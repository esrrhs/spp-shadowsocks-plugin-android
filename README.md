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
```
* 编译
```
# rm app/build -rf
# docker run --rm -u root -v ${PWD}:/build -w /build shadowsocks/android-ndk-go ./gradlew assembleDebug
```
