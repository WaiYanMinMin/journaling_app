import 'package:flutter/material.dart';
import 'package:journaling_app/l10n/l10n.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;
  String data = 'null';
  bool searchCheck = false;
  void changeString(String newString) {
    data = newString;

    notifyListeners();
  }

  void isSearch(bool result) {
    searchCheck = result;

    notifyListeners();
  }

  void setLocale(Locale locale) async {
    if (!L10n.all.contains(locale)) return;
    await UserSimplePreferences.setLanguage(locale.languageCode);
    _locale = locale;

    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
