package com.example.pingtalk.ptt

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.*
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat

class PttActivity : ComponentActivity() {
    private val requestPermission = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { granted ->
        if (granted) startCaptureServiceAndFinish() else finish()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO)
            == PackageManager.PERMISSION_GRANTED) {
            startCaptureServiceAndFinish()
        } else {
            requestPermission.launch(Manifest.permission.RECORD_AUDIO)
        }
    }

    private fun startCaptureServiceAndFinish() {
        val i = Intent(this, CaptureService::class.java)
        ContextCompat.startForegroundService(this, i)
        Handler(Looper.getMainLooper()).postDelayed({ finish() }, 300)
    }
}
