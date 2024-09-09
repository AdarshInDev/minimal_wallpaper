import 'package:flutter/material.dart';
import 'package:minimal_wallpaper/themes.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkMode;
  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
