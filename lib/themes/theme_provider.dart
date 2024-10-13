import 'package:flutter/material.dart';
import 'package:gradution_project/themes/dark_mode.dart';

import 'package:gradution_project/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData)
  {
    _themeData = themeData;
    notifyListeners();
  }

  bool isDarkMode() => _themeData==darkMode;

  void toggleTheme ()
  {
    if (_themeData == lightMode){
      themeData = darkMode;
    }else {
      themeData = lightMode;
    }
  }
}