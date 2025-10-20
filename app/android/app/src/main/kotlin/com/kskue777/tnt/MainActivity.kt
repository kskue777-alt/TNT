package com.kskue777.tnt

import android.content.Intent
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startRecording" -> {
                    startServiceCompat(PttForegroundService.ACTION_START_RECORDING)
                    result.success(null)
                }
                "stopAndSend" -> {
                    startServiceCompat(PttForegroundService.ACTION_STOP_AND_SEND)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startServiceCompat(action: String) {
        val intent = Intent(this, PttForegroundService::class.java).apply {
            this.action = action
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            startForegroundService(intent)
        } else {
            startService(intent)
        }
    }

    companion object {
        private const val CHANNEL = "ptt.service"
    }
}
