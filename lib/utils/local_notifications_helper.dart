import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../components/custom_snackbar.dart';

class LocalNotificationsHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(settings);

    // timezone data initalization
    try {
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));
    } catch (e) {
      debugPrint("Timezone 初期化エラー発生: $e");
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  static Future<void> scheduleNotification(
    BuildContext context,
    int id,
    String title,
    String body,
    TimeOfDay time,
  ) async {
    try {
      final now = DateTime.now();
      final scheduledTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      final tz.TZDateTime tzScheduledTime =
          tz.TZDateTime.from(scheduledTime, tz.local);

      AndroidNotificationDetails androidDetails =
          const AndroidNotificationDetails(
        'task_channel_id',
        'Task Notifications',
        channelDescription: 'タスクのリマインダー通知',
        importance: Importance.high,
        priority: Priority.high,
      );

      NotificationDetails details =
          NotificationDetails(android: androidDetails);

      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzScheduledTime,
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

      // Contextが有効になった場合はアラートを表示　：mounted:Widgetが破壊されているかを確認する

      if (context.mounted) {
        CustomSnackbar.show(context, "アラームが正常に設定されました！");
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackbar.show(context, "アラーム設定エラーが発生しました。: $e");
      }
    }
  }
}
