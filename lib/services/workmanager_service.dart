import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:madang_app/data/api/api_services.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';
import 'package:madang_app/services/local_notification_service.dart';
import 'package:madang_app/static/reminder_workmanager.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == ReminderWorkmanager.periodicTask.taskName ||
        task == ReminderWorkmanager.periodicTask.uniqueName ||
        task == Workmanager.iOSBackgroundTask) {
      final apiService = ApiServices();

      List<Restaurants> resultList;
      final result = await apiService.getRestaurants();
      if (!result.error) {
        resultList = result.restaurants;
        //mengambil index acak
        int randomIndex = Random().nextInt(resultList.length);
        final dataInput = resultList[randomIndex];


        //Simple
        const androidPlatformChannelSpecifics = AndroidNotificationDetails(
            "3", "Daily Notification",
            importance: Importance.max, priority: Priority.high);
        const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
        const notificationDetails = NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: iOSPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(
            1,
            "Ayo Makan Siang di ${dataInput.name}",
            dataInput.description,
            notificationDetails,
            payload: dataInput.id);
      }
    }
    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _wm;

  WorkmanagerService([Workmanager? workmanager])
      : _wm = workmanager ??= Workmanager();

  Future<void> init() async {
    await _wm.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Duration calculationInitialDelay() {
    final now = DateTime.now();
    final targetTime = DateTime(now.year, now.month, now.day, 15, 18);

    if (now.isAfter(targetTime)) {
      //Jika waktu sekarang sudah lewat jam 11, jadwalkan hari berikutnya
      return targetTime.add(const Duration(days: 1)).difference(now);
    } else {
      //Jika waktu saat ini sebelum jam 11
      return targetTime.difference(now);
    }
  }

  Future<void> runPeriodicTask() async {
    final initialDelay = calculationInitialDelay();
    await _wm.registerPeriodicTask(
      ReminderWorkmanager.periodicTask.uniqueName,
        ReminderWorkmanager.periodicTask.taskName,
        constraints: Constraints(networkType: NetworkType.connected),
        frequency: const Duration(days: 1),
        initialDelay: initialDelay,
        inputData: {
          "data": "this is a valid payload from reminder task workmanager"
      });
  }

  Future<void> cancellAlltask() async {
    await _wm.cancelAll();
  }
}
