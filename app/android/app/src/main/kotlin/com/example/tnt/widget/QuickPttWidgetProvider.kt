package com.example.tnt.widget

import android.app.AlarmManager
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

private const val TAG = "QuickPttWidgetProvider"
private const val UPDATE_ACTION = "com.example.tnt.widget.UPDATE"

/**
 * Android home screen widget provider for the quick PTT shortcut.
 *
 * The implementation is intentionally light-weight and contains scheduling stubs so the
 * production code can plug in WorkManager/AlarmManager later without refactoring.
 */
class QuickPttWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        super.onUpdate(context, appWidgetManager, appWidgetIds)
        Log.d(TAG, "Updating quick PTT widget for ids: " + appWidgetIds.joinToString())

        // TODO(mvp-widget-1): Bind actual friend data via RemoteViews & HomeWidget.

        scheduleNextUpdate(context)
    }

    override fun onEnabled(context: Context) {
        super.onEnabled(context)
        scheduleNextUpdate(context)
    }

    override fun onDisabled(context: Context) {
        super.onDisabled(context)
        cancelScheduledUpdates(context)
    }

    private fun scheduleNextUpdate(context: Context) {
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val pendingIntent = buildUpdateIntent(context)

        // TODO(mvp-widget-1): Replace with appropriate cadence once backend is ready.
        val triggerAtMillis = System.currentTimeMillis() + 15 * 60 * 1000 // 15 minutes stub

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            alarmManager.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                triggerAtMillis,
                pendingIntent
            )
        } else {
            alarmManager.setExact(AlarmManager.RTC_WAKEUP, triggerAtMillis, pendingIntent)
        }
        Log.d(TAG, "Scheduled next widget refresh in 15 minutes (stub)")
    }

    private fun cancelScheduledUpdates(context: Context) {
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.cancel(buildUpdateIntent(context))
        Log.d(TAG, "Cancelled widget update schedule")
    }

    private fun buildUpdateIntent(context: Context): PendingIntent {
        val intent = Intent(context, QuickPttWidgetProvider::class.java)
        intent.action = UPDATE_ACTION
        intent.component = ComponentName(context, QuickPttWidgetProvider::class.java)

        return PendingIntent.getBroadcast(
            context,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == UPDATE_ACTION) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(
                ComponentName(context, QuickPttWidgetProvider::class.java)
            )
            if (ids.isNotEmpty()) {
                onUpdate(context, manager, ids)
            }
        }
    }
}
