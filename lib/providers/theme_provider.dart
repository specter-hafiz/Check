import 'package:check/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme;
  ThemeData get themeData => _themeData;

  final String _themePreferenceKey = 'theme_preference';

  ThemeProvider() {
    _loadTheme();
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeIndex = prefs.getInt(_themePreferenceKey) ?? 0;
    _themeData = themeIndex == 0 ? lightTheme : darkTheme;
    notifyListeners();
  }

  _saveTheme(int themeIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themePreferenceKey, themeIndex);
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
    _saveTheme(themeData == lightTheme ? 0 : 1);
  }

  toggleTheme() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
