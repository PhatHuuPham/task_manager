import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('vi');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!locale.languageCode.contains(_locale.languageCode)) {
      _locale = locale;
      notifyListeners();
    }
  }
}
