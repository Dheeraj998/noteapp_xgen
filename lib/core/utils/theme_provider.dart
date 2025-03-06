import 'package:flutter/material.dart';
import 'package:notes_app_xgen/core/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;
  bool _isDarkMode = false;

  ThemeProvider() {
    _loadThemePreference();
  }

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;

  /// Toggle between Light & Dark mode
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
    _saveThemePreference();
    notifyListeners();
  }

  /// Save theme preference locally
  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  /// Load theme preference on app start
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeData = _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
    notifyListeners();
  }
}
