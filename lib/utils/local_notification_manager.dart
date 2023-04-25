import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  // Create an instance of the NotificationPlugin class.

  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    _notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    // Initializing the notification plugin.
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    tz.initializeTimeZones();

    await _notificationPlugin.initialize(initializationSettings);
  }

  // Show notification with a custom sound.
  Future showNotificationWithSound(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _notificationPlugin.show(0, title, body, platformChannelSpecifics,
        payload: 'custom_payload');
  }

  // Schedule daily notification with a custom sound at a specified time.
  Future<void> scheduleDailyNotificationWithSound({
    required int id,
    required String title,
    required String body,
    required Time time,
  }) async {
    final now = DateTime.now();

    final notificationTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Notifications',
      channelDescription: 'For Scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    final DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(notificationTime, tz.local),
      //? This time zone should match the device's time zone.
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'custom_payload',
      //? Schedule the notification to repeat every day.
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotificationById({required int id}) async {
    await _notificationPlugin.cancel(id).then(
          (value) => log("notification canceled successfully"),
        );
  }

  Future<void> cancelAllNotifications() async {
    await _notificationPlugin.cancelAll().then(
          (value) => log("all notification canceled successfully"),
        );
  }
}
