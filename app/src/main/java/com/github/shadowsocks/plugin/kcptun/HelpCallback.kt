package com.github.shadowsocks.plugin.spp

import com.github.shadowsocks.plugin.PluginOptions

class HelpCallback : com.github.shadowsocks.plugin.HelpCallback() {
    override fun produceHelpMessage(options: PluginOptions): CharSequence =
            ProcessBuilder(applicationInfo.nativeLibraryDir + "/libspp.so", "--help")
                    .redirectErrorStream(true)
                    .start()
                    .inputStream.bufferedReader().useLines {
                        it.joinToString("\n")
                    }
}
