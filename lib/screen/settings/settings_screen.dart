import 'package:flutter/material.dart';
import 'package:madang_app/provider/shared_preferences_provider.dart';
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
    debugPrint(sharedPrefProvider.theme.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
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
                    Consumer<SharedPreferencesProvider>(
                        builder: (context, value, child) {
                      return Switch(
                          thumbIcon: WidgetStatePropertyAll(Icon(value.theme
                              ? Icons.light_mode
                              : Icons.nights_stay_rounded)),
                          value: value.theme,
                          onChanged: (bool value) => changeTheme(value));
                    })
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
                        thumbIcon: const WidgetStatePropertyAll(
                            Icon(Icons.timer_sharp)),
                        value: false,
                        onChanged: (bool value) {})
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
