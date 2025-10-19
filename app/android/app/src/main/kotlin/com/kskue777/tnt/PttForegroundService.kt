package com.kskue777.tnt

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat

class PttForegroundService : Service() {
    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val action = intent?.action
        ensureChannel()
        startForeground(NOTIFICATION_ID, buildNotification(action))
        // TODO: hook up real audio capture and transport logic.
        if (action == ACTION_STOP_AND_SEND) {
            stopForeground(STOP_FOREGROUND_REMOVE)
            stopSelfResult(startId)
        }
        return START_NOT_STICKY
    }

    private fun ensureChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Push To Talk",
                NotificationManager.IMPORTANCE_DEFAULT
            )
            manager.createNotificationChannel(channel)
        }
    }

    private fun buildNotification(action: String?): Notification {
        val content = when (action) {
            ACTION_START_RECORDING -> "녹음 중"
            ACTION_STOP_AND_SEND -> "전송 중"
            else -> "대기 중"
        }
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.ic_btn_speak_now)
            .setContentTitle("TNT Push-To-Talk")
            .setContentText(content)
            .setOngoing(true)
            .build()
    }

    companion object {
        const val ACTION_START_RECORDING = "com.kskue777.tnt.START_RECORDING"
        const val ACTION_STOP_AND_SEND = "com.kskue777.tnt.STOP_AND_SEND"
        private const val CHANNEL_ID = "tnt_ptt_channel"
        private const val NOTIFICATION_ID = 1001
    }
}
