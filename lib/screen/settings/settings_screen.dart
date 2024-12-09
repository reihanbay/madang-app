import 'package:flutter/material.dart';
import 'package:madang_app/provider/local_notifications_provider.dart';
import 'package:madang_app/provider/settings/shared_preferences_provider.dart';
import 'package:madang_app/services/workmanager_service.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void changeTheme(bool value) async {
    final sharedPrefProvider = context.read<SharedPreferencesProvider>();
    await sharedPrefProvider.setTheme(value);
    sharedPrefProvider.getTheme();
  }

  void setReminder(bool state) async {
    final sharedPrefProvider = context.read<SharedPreferencesProvider>();
    final localPrefProvider = context.read<LocalNotificationsProvider>();
    await localPrefProvider.requestPermissions();
    await sharedPrefProvider.setDReminder(state);
    sharedPrefProvider.getDRemind();

    if (Provider.of<SharedPreferencesProvider>(context, listen: false)
        .reminder) {
      context.read<WorkmanagerService>().runPeriodicTask();
      // final payload = sharedPrefProvider.payload;
      // localPrefProvider.showDailyNotification("title", "body", payload);
    } else {
      context.read<WorkmanagerService>().cancellAlltask();
      context.read<LocalNotificationsProvider>().cancelNotifications();
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            Provider.of<SharedPreferencesProvider>(context, listen: false)
                .message)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Consumer<SharedPreferencesProvider>(
              builder: (context, value, child) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.topLeft,
                  child: Text("Settings",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 32)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Theme Mode",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      Switch(
                          thumbIcon: WidgetStatePropertyAll(Icon(value.theme
                              ? Icons.light_mode
                              : Icons.nights_stay_rounded)),
                          value: value.theme,
                          onChanged: (bool value) => changeTheme(value))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Daily Reminder On/Off",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      Switch(
                          thumbIcon: WidgetStatePropertyAll(Icon(value.reminder
                              ? Icons.timer_sharp
                              : Icons.timer_off)),
                          value: value.reminder,
                          onChanged: (bool value) {
                            setReminder(value);
                          })
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
