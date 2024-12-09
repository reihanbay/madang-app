import 'package:flutter/foundation.dart';
import 'package:madang_app/services/shared_preferences_services.dart';

class SharedPreferencesProvider extends ChangeNotifier{
  final SharedPreferencesServices _services;

  SharedPreferencesProvider(this._services);

  

  String _message = "";
  String get message => _message;

  bool _theme = false ;
  bool get theme => _theme;

  bool _reminder = false;
  bool get reminder => _reminder;

  Future<void> setTheme(bool value) async {
    try {
      await _services.setTheme(value);
      _message = "Success saved!";
    } catch (e) {
      _message = "${e.toString()}!";
      throw Exception(e.toString());
    }
    notifyListeners();
  }

  void getTheme() async {
    try {
      _theme = _services.getThemeSetting();
       print(_theme.toString());
      _message = "Data Success retrieved";
    } catch (e) {
      _message = "Failed get data";
    }
    notifyListeners();
  }

  void getDRemind() async {
    try {
       _reminder = _services.getDRemindSetting();
       print(_reminder.toString());
      _message = "Data Success retrieved";
    } catch (e) {
      _message = "Failed get data";
    }
    notifyListeners();
  }
  

  Future<void> setDReminder(bool value) async {
    try {
      await _services.setDReminder(value);
      _message = "Success set reminder at 11:00 AM";
    } catch (e) {
      _message = "${e.toString()}!";
      throw Exception(e.toString());
    }
    notifyListeners();
  }


}