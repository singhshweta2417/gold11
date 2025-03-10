import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/app_const.dart';

class LanguageViewModel with ChangeNotifier {
  Locale? _appLocal;
  Locale? get appLocal => _appLocal;

  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'hi', 'name': 'Hindi'},
  ];


  void changeLanguage(Locale languageKey) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _appLocal = languageKey;
    String languageCode = AppConstants.defaultLanguage;
    switch (languageKey.languageCode) {
      case 'en':
        languageCode = 'en';
        break;
      case 'hi':
        languageCode = 'hi';
        break;
      default:
        languageCode = AppConstants.defaultLanguage;
        break;
    }

    await sp.setString('language_code', languageCode);
    notifyListeners();
  }

  Future loadLanguage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return Locale(sp.getString('language_code') ?? AppConstants.defaultLanguage);
  }
}