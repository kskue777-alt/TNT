package com.example.pingtalk.ptt

import android.app.*
import android.content.*
import android.os.IBinder
import androidx.core.app.NotificationCompat
import com.example.pingtalk.R

class PlaybackService : Service() {
    companion object {
        const val CHANNEL_ID = "ptt_playback"
        const val NOTI_ID = 101
    }
    override fun onCreate() {
        super.onCreate()
        val mgr = getSystemService(NotificationManager::class.java)
        val channel = NotificationChannel(CHANNEL_ID, "PTT Playback", NotificationManager.IMPORTANCE_LOW)
        mgr.createNotificationChannel(channel)

        val noti = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("핑톡 - 자동 재생 활성")
            .setContentText("수신 보이스를 바로 재생합니다")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setOngoing(true)
            .build()
        startForeground(NOTI_ID, noti)
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // TODO: Flutter 쪽에서 MethodChannel로 재생 트리거 연결
        return START_STICKY
    }
    override fun onBind(p0: Intent?): IBinder? = null
}
