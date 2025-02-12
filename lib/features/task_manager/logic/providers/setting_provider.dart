import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  Locale _locale = const Locale('vi');
  ThemeMode _themeMode = ThemeMode.system; // Mặc định theo hệ thống

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;

  SettingProvider() {
    // _loadPreferences();
  }

  void setLocale(Locale locale) {
    if (_locale.languageCode != locale.languageCode) {
      _locale = locale;
      // _savePreferences();
      notifyListeners();
    }
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    // _savePreferences();
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(surface: Colors.white),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(surface: Colors.black),
      );

  // Future<void> _loadPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _locale = Locale(prefs.getString('language') ?? 'vi');
  //   _themeMode = ThemeMode.values[prefs.getInt('themeMode') ?? 2];
  //   notifyListeners();
  // }

  // Future<void> _savePreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('language', _locale.languageCode);
  //   prefs.setInt('themeMode', _themeMode.index);
  // }
}
