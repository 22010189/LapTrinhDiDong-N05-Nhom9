import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  ThemeData getTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        return ThemeData.light().copyWith(primaryColor: Colors.teal);
      case ThemeMode.dark:
        return ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.teal,
        );
      default:
        return ThemeData(
          brightness: Brightness.light,
        );
    }
  }
}
