import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController._();

  static final ThemeController instance = ThemeController._();

  static const String _themePreferenceKey = 'portfolio_theme_mode_system_v2';

  ThemeMode _themeMode = ThemeMode.system;
  bool _initialized = false;

  ThemeMode get themeMode => _themeMode;

  bool get isSystemMode => _themeMode == ThemeMode.system;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.dark) {
      return true;
    }

    if (_themeMode == ThemeMode.light) {
      return false;
    }

    return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }

  bool get isLightMode => !isDarkMode;

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
        'system' => ThemeMode.system,
        _ => ThemeMode.system,
      };
    } catch (_) {
      _themeMode = ThemeMode.system;
    } finally {
      _initialized = true;
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    final targetMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;

    await setThemeMode(targetMode);
  }

  Future<void> useSystemTheme() async {
    await setThemeMode(ThemeMode.system);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) {
      return;
    }

    _themeMode = mode;
    notifyListeners();

    try {
      final preferences = await SharedPreferences.getInstance();

      final value = switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };

      await preferences.setString(_themePreferenceKey, value);
    } catch (_) {}
  }
}
