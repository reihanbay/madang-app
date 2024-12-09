import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:madang_app/data/model/received_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotifications>
    didReceiveLocalNotificationStream =
    StreamController<ReceivedNotifications>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

class LocalNotificationService {
  Future<void> init() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettingsDarwin = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) {
      final payload = response.payload;
      if (payload != null && payload.isNotEmpty) {
        selectNotificationStream.add(payload);
      }
    });
  }

  Future<bool> isAndroidPermissionGranted() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
  }

  Future<bool> requestAndroidNotificationsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;
  }

  Future<bool?> requestPermissions() async {
    
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      return await iosImplementation?.requestPermissions(
          sound: true, alert: true, badge: true);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final notificationEnabled = await isAndroidPermissionGranted();
      final requestAlarmEnabled = await _requestExactAlarmsPermission();
      if (!notificationEnabled) {
        final requestNotificationsPermission =
            await requestAndroidNotificationsPermission();
        return requestNotificationsPermission;
      }
      return notificationEnabled && requestAlarmEnabled;
    } else {
      return false;
    }
  }

  //Scheduled Notification
  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  tz.TZDateTime _nextInstanceOfElvAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 12);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  Future<bool> _requestExactAlarmsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestExactAlarmsPermission() ??
        false;
  }

  Future<void> showDailyNotification({
    required int id,
    required String title,
    required String body,
    String payload = "",
    String channelId = "1",
    String channelName = "Daily Reminder",
  }) async {
    final androidNotifDetails = AndroidNotificationDetails(
        channelId, channelName,
        importance: Importance.high, priority: Priority.high, ticker: 'ticker');

    const iosNotifDetails = DarwinNotificationDetails();

    final notificationDetails =
        NotificationDetails(android: androidNotifDetails, iOS: iosNotifDetails);

    final schedule = _nextInstanceOfElvAM();

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id, title, body, schedule, notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<List<PendingNotificationRequest>> pendingNotificationRequest() async {
    final List<PendingNotificationRequest> pendingNotificationRequest = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotificationRequest;
  }


  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
