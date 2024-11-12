package com.github.shadowsocks.plugin.spp

import android.content.ActivityNotFoundException
import androidx.appcompat.app.AlertDialog
import androidx.core.os.bundleOf
import androidx.preference.EditTextPreferenceDialogFragmentCompat
import com.github.shadowsocks.plugin.R
import com.google.android.material.snackbar.Snackbar

class CertificatePreferenceDialogFragment : EditTextPreferenceDialogFragmentCompat() {
    fun setKey(key: String) {
        arguments = bundleOf(Pair(ARG_KEY, key))
    }


    override fun onPrepareDialogBuilder(builder: AlertDialog.Builder) {
        super.onPrepareDialogBuilder(builder)
        builder.setNeutralButton(R.string.browse) { _, _ ->
            val activity = requireActivity()
            try {
                (targetFragment as ConfigFragment).browseCertificate.launch("application/pkix-cert")
                return@setNeutralButton
            } catch (_: ActivityNotFoundException) { } catch (_: SecurityException) { }
            Snackbar.make(activity.findViewById(R.id.content), R.string.file_manager_missing, Snackbar.LENGTH_SHORT)
                    .show()
        }
    }
}
