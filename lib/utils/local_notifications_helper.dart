import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/task_model.dart';
import '../components/custom_snackbar.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/src/platform_specifics/android/schedule_mode.dart';

class LocalNotificationsHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //初期化＆権限設定
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings);

    // timezone initalization
    try {
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));
    } catch (e) {
      debugPrint("Timezone 初期化エラー: $e");
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  /// alarm setting including repeat options
  static Future<void> scheduleNotification(
    BuildContext context,
    int id,
    String title,
    String body,
    TimeOfDay time,
    Repeat repeat,
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

      // android notification settings
      AndroidNotificationDetails androidDetails =
          const AndroidNotificationDetails(
        'task_channel_id',
        'Task Notifications',
        channelDescription: 'タスクのリマインダー通知',
        importance: Importance.high,
        priority: Priority.high,
      );

      // ios notification settings
      DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      NotificationDetails details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // Repeat options
      DateTimeComponents? matchDateTimeComponents;
      if (repeat == Repeat.daily) {
        matchDateTimeComponents = DateTimeComponents.time;
      } else if (repeat == Repeat.weekly) {
        matchDateTimeComponents = DateTimeComponents.dayOfWeekAndTime;
      } else if (repeat == Repeat.monthly) {
        matchDateTimeComponents = DateTimeComponents.dayOfMonthAndTime;
      }

      // repeat = none : one-time alarmsetting

      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzScheduledTime,
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents:
            repeat != Repeat.none ? matchDateTimeComponents : null,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );

      if (context.mounted) {
        CustomSnackbar.show(context, 'アラームが正常に設定されました！');
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackbar.show(context, 'アラーム設定エラー: $e');
      }
    }
  }
}
