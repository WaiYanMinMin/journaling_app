import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';

import 'package:journaling_app/l10n/l10n.dart';

import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;
  String data = 'null';
  bool searchCheck = false;
  String _color = 'blue';
  int _index = 0;
  void setcolor(String color) async {
    await UserSimplePreferences.setColor(color);
    _color = color;
    notifyListeners();
  }

  getcolor() {
    return _color;
  }

  void setindex(int index) {
    _index = index;
    notifyListeners();
  }

  getindex() {
    return _index;
  }

  /* EventDao eventDao = Get.find(); */
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  DateTime setDate(DateTime date) => _selectedDate = date;
/*   Stream<List<Event>> get eventofSelectedDate =>eventDao.getAllEvent(); */
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
