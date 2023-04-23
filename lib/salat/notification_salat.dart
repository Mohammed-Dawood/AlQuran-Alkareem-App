import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationSalat {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final onNotifications = BehaviorSubject<NotificationResponse>();

  Future<void> initNotification({bool initScheduled = false}) async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) async {},
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        onNotifications.add(notificationResponse);
      },
      // onDidReceiveBackgroundNotificationResponse:
      //     (NotificationResponse notificationResponse) async {
      //   onNotifications.add(notificationResponse);
      // },
    );
    // if (initScheduled) {
    //   tz.initializeTimeZones();
    //   final locationName = await FlutterNativeTimezone.getLocalTimezone();
    //   tz.setLocalLocation(tz.getLocation(locationName));
    // }
  }

  Future notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'App',
        'Quran App',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required String payLoad,
    required DateTime scheduledDate,
  }) async {
    print(
        "${scheduledDate.hour}:${scheduledDate.minute}:${scheduledDate.second}");
    tz.initializeTimeZones();
    return notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      // tz.TZDateTime.from(scheduledDate, tz.local).add(Duration(seconds: 5)),
      // "${prayerTimes.fajr!.toLocal().hour}:${prayerTimes.fajr!.toLocal().minute}"
      // schedulesDaily(
      //   Time(19, 45, 30
      //       // scheduledDate.hour,
      //       // scheduledDate.minute,
      //       // scheduledDate.second,
      //       ),
      // ),
      await notificationDetails(),
      payload: payLoad,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime schedulesDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);

    final scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    print("${time.hour}::${time.minute}::${time.second}");
    return scheduleDate;
  }

  Future NotificationCancel({required int id}) async {
    notificationsPlugin.cancel(id);
    print("Cancel id $id");
  }
}
