import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:madang_app/services/local_notification_service.dart';

class LocalNotificationsProvider extends ChangeNotifier {
  final LocalNotificationService notificationService;

  LocalNotificationsProvider(this.notificationService);

  int notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;
  List<PendingNotificationRequest> pendingNotificationRequest = [];

  Future<void> requestPermissions() async {
    _permission = await notificationService.requestPermissions();
    notifyListeners();
  }

  void showDailyNotification(String title, String body, String payload) {
    notificationService.showDailyNotification(id: 5,title: title, body: body, payload: payload);
  }

  Future<void> checkPendingNotificationRequest()async {
    pendingNotificationRequest = await notificationService.pendingNotificationRequest();
    notifyListeners();
  }


  Future<void> cancelNotifications() async {
    await notificationService.cancelAllNotification();
  }

}
