import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  ThemeProvider() {
    _loadThemePreference();
  }

  void _loadThemePreference() {
    var themeMode = ThemeMode.system;
    _getThemePreference()
        .then((themeModePreference) {
          if (themeModePreference == null) {
            return;
          }
          themeMode = themeModePreference;
        })
        .catchError((error) {});
    setTheme(themeMode);
  }

  void setTheme(ThemeMode mode) async {
    await _setThemePreference(mode);
    themeMode = mode;
    notifyListeners();
  }

  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<ThemeMode?> _getThemePreference() async {
    final prefs = await _getSharedPreferences();
    final themeIndex = prefs.getInt("Constants.THEME_KEY");
    if (themeIndex == null) return null;
    return ThemeMode.values[themeIndex];
  }

  Future<void> _setThemePreference(ThemeMode mode) async {
    final prefs = await _getSharedPreferences();
    await prefs.setInt("Constants.THEME_KEY", mode.index);
  }
}
