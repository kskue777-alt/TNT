package com.example.pingtalk.ptt

import android.app.*
import android.content.*
import android.os.IBinder
import androidx.core.app.NotificationCompat
import com.example.pingtalk.R

class CaptureService : Service() {
    companion object {
        const val CHANNEL_ID = "ptt_capture"
        const val NOTI_ID = 102
    }
    override fun onCreate() {
        super.onCreate()
        val mgr = getSystemService(NotificationManager::class.java)
        val channel = NotificationChannel(CHANNEL_ID, "PTT Capture", NotificationManager.IMPORTANCE_LOW)
        mgr.createNotificationChannel(channel)

        val noti = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("핑톡 - 녹음 중")
            .setContentText("버튼 누르는 동안 송신")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setOngoing(true)
            .build()
        startForeground(NOTI_ID, noti)
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // TODO: Flutter/PlatformChannel로 마이크 스트림 전달(WebRTC 연결은 다음 단계)
        return START_NOT_STICKY
    }
    override fun onBind(p0: Intent?): IBinder? = null
}
