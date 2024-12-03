
import 'package:flutter/foundation.dart';

class BottomNavProvider extends ChangeNotifier{
  int _indexBottomNav = 0;

  int get indexBottomNav => _indexBottomNav;

  set setIndexBottomNav(int value) {
    _indexBottomNav = value;
    notifyListeners();
  }
}