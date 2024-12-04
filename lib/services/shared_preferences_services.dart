import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  final SharedPreferences pref;

  SharedPreferencesServices(this.pref);

  static const String keyTheme = "SET_THEME";
  static const String keyDRemind = "SET_DAILY_REMIND";

  Future<void> setTheme(bool state) async {
    try {
      await pref.setBool(keyTheme, state);
    } catch (e) {
      throw Exception("Cannot Set Theme");
    }
  }

  bool getThemeSetting() {
    return pref.getBool(keyTheme) ?? false;
  }

  Future<void> setDReminder(bool state) async {
    try {
      await pref.setBool(keyDRemind, state);
    } catch (e) {
      throw Exception("Cannot set daily reminder");
    }
  }

  bool getDRemindSetting() {
    return pref.getBool(keyDRemind) ?? false;
  }



}