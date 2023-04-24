import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

AwesomeNotificationManager awesomeNotificationManager =
    AwesomeNotificationManager();

class AwesomeNotificationManager {
  Future<void> checkIfAllowed(BuildContext context) async {
    try {
      await AwesomeNotifications().isNotificationAllowed().then(
        (isAllowed) {
          if (!isAllowed) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                title: Text("Allow app to send notifications?".tr),
                content: Text(
                  "AlQuran AlKareem need notification permission to send reminders."
                      .tr,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Later".tr,
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () => AwesomeNotifications()
                        .requestPermissionToSendNotifications()
                        .then((_) => Navigator.pop(context)),
                    child: Text(
                      "Allow".tr,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> init() async {
    try {
      await AwesomeNotifications().initialize(
        /// using null here mean it will use app icon for notification icon
        /// If u want use custom one replace null with below
        /// 'resource://drawable/res_app_icon',
        null,
        [
          NotificationChannel(
            channelKey: 'in_app_notification',
            channelName: 'In App Notification',
            channelDescription: 'For internal notifications',
            defaultColor: Colors.teal,
            importance: NotificationImportance.High,
            channelShowBadge: true,
            enableLights: true,
            playSound: true,
          ),
          NotificationChannel(
            channelKey: 'scheduled_channel',
            channelName: 'Scheduled Notifications',
            channelDescription: 'For Scheduled notifications',
            defaultColor: Colors.teal,
            importance: NotificationImportance.High,
            locked: true,
            channelShowBadge: true,
            playSound: true,
          ),
        ],
        debug: true,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  void listen() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// Check if awesome notification is allowed
      await awesomeNotificationManager.checkIfAllowed(Get.context!);

      await AwesomeNotifications()
          .setListeners(onActionReceivedMethod: onActionReceivedMethod);
    });
  }

  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    final List<String?> payloadsList = receivedAction.payload!.values.toList();
    final String? payload = payloadsList[0];

    log("actionStream: $payload");
    final bool channelCheck =
        receivedAction.channelKey == 'in_app_notification' ||
            receivedAction.channelKey == 'scheduled_channel';
    if (channelCheck && Platform.isIOS) {
      await AwesomeNotifications().getGlobalBadgeCounter().then(
        (value) async {
          await AwesomeNotifications().setGlobalBadgeCounter(value - 1);
        },
      );
    }

    if (payload!.isNotEmpty) {
      onNotificationClick(payload);
    } else {
      log("actionStream: Else");
    }
  }

  Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }

  Future<void> cancelNotificationById({
    required int id,
  }) async {
    await AwesomeNotifications().cancelSchedule(id);
  }

  /// Show Notification
  Future<void> showCustomNotification({
    required String title,
    String? body,
    required String payload,
  }) async {
    //? int id = createUniqueId();c
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 999,
        channelKey: 'in_app_notification',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.BigText,
        payload: {'Open': payload},
        fullScreenIntent: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'Dismiss',
          label: 'Dismiss'.tr,
          actionType: ActionType.DisabledAction,
        ),
        NotificationActionButton(
          key: 'Start',
          label: 'Start'.tr,
        ),
      ],
    );
  }

  //* Show Notification
  Future<void> appOpenNotification() async {
    final scheduleNotificationDateTime =
        DateTime.now().add(const Duration(days: 3));
    // int id = createUniqueId();c
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1000,
        channelKey: 'scheduled_channel',
        title: "You haven't opened the app for a long time.".tr,
        body: 'فَاذْكُرُونِي أَذْكُرْكُمْ وَاشْكُرُوا لِي وَلَا تَكْفُرُونِ',
        notificationLayout: NotificationLayout.BigText,
        payload: {'Open': "2"},
      ),
      schedule: NotificationCalendar.fromDate(
        date: scheduleNotificationDateTime,
        allowWhileIdle: true,
        repeats: true,
        preciseAlarm: true,
      ),
    );
  }

  //* Add weekly notification
  Future<void> addCustomWeeklyReminder({
    required int id,
    required String title,
    String? body,
    required String payload,
    required Time time,
    int? weekday,
    bool needToOpen = true,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'scheduled_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.BigText,
        payload: {'Open': payload},
      ),
      schedule: NotificationCalendar(
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: true,
        weekday: weekday,
        hour: time.hour,
        minute: time.minute,
        second: 0,
        millisecond: 0,
      ),
      actionButtons: needToOpen
          ? [
              NotificationActionButton(
                key: 'Dismiss',
                label: 'Dismiss'.tr,
                actionType: ActionType.DisabledAction,
              ),
              NotificationActionButton(
                key: 'Start',
                label: 'Start'.tr,
              ),
            ]
          : [
              NotificationActionButton(
                key: 'Dismiss',
                label: 'Dismiss'.tr,
                actionType: ActionType.DisabledAction,
              ),
            ],
    );
  }

  //* Add Daily notification
  Future<void> addCustomDailyReminder({
    required int id,
    required String title,
    String? body,
    required Time time,
    required String payload,
    bool needToOpen = true,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'scheduled_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.BigText,
        payload: {'Open': payload},
      ),
      schedule: NotificationCalendar(
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
        allowWhileIdle: true,
        hour: time.hour,
        minute: time.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
      ),
      actionButtons: needToOpen
          ? [
              NotificationActionButton(
                key: 'Dismiss',
                label: 'Dismiss'.tr,
                actionType: ActionType.DisabledAction,
              ),
              NotificationActionButton(
                key: 'Start',
                label: 'Start'.tr,
              ),
            ]
          : [
              NotificationActionButton(
                key: 'Dismiss',
                label: 'Dismiss'.tr,
                actionType: ActionType.DisabledAction,
              ),
            ],
    );
  }

  ///
  static void onNotificationClick(String payload) {
    /// go to quran page if clicked
    //? if you want to do action when opening the app
    //? you can check Payload
    //* for example
    //if(payload == "الفجر"){
    //  Navigator.of(context).pushNamed(ScreenSalat.routeName);
    //}
  }

  void dispose() {
    // AwesomeNotifications().actionSink.close();
    // AwesomeNotifications().createdSink.close();
  }
}
