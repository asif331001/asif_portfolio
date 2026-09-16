import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController._();

  static final ThemeController instance = ThemeController._();

  static const String _themePreferenceKey = 'portfolio_theme_mode';

  ThemeMode _themeMode = ThemeMode.dark;
  bool _initialized = false;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  bool get isLightMode => _themeMode == ThemeMode.light;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    try {
      final preferences = await SharedPreferences.getInstance();
      final savedTheme = preferences.getString(_themePreferenceKey);

      _themeMode = switch (savedTheme) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.dark,
      };
    } catch (_) {
      _themeMode = ThemeMode.dark;
    } finally {
      _initialized = true;
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    await setThemeMode(
      _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode != ThemeMode.dark && mode != ThemeMode.light) {
      return;
    }

    if (_themeMode == mode) {
      return;
    }

    _themeMode = mode;
    notifyListeners();

    try {
      final preferences = await SharedPreferences.getInstance();

      await preferences.setString(
        _themePreferenceKey,
        mode == ThemeMode.light ? 'light' : 'dark',
      );
    } catch (_) {
      // Theme still changes for the current session even if persistence fails.
    }
  }
}
