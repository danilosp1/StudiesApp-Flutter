import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleViewModel extends ChangeNotifier {
  static const String _languageCodeKey = 'appLanguageCode';
  Locale? _appLocale;

  Locale? get appLocale => _appLocale;

  LocaleViewModel() {
    loadLocale();
  }

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageCodeKey);

    if (languageCode != null && languageCode.isNotEmpty) {
      _appLocale = Locale(languageCode);
    } else {
      _appLocale = const Locale('pt'); 
    }
    notifyListeners();
  }

  Future<void> changeLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, languageCode);
    _appLocale = Locale(languageCode);
    notifyListeners();
  }
}