package com.github.shadowsocks.plugin.spp

import android.net.Uri
import android.os.ParcelFileDescriptor
import com.github.shadowsocks.plugin.NativePluginProvider
import com.github.shadowsocks.plugin.PathProvider
import java.io.File
import java.io.FileNotFoundException

class BinaryProvider : NativePluginProvider() {
    override fun populateFiles(provider: PathProvider) {
        provider.addPath("spp-plugin", 0b111101101)
    }
    override fun getExecutable() = context!!.applicationInfo.nativeLibraryDir + "/libspp.so"
    override fun openFile(uri: Uri): ParcelFileDescriptor = when (uri.path) {
        "/spp-plugin" -> ParcelFileDescriptor.open(File(getExecutable()), ParcelFileDescriptor.MODE_READ_ONLY)
        else -> throw FileNotFoundException()
    }
}
