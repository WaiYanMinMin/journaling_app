import 'package:flutter/material.dart';
import 'package:journaling_app/l10n/l10n.dart';
import 'package:journaling_app/src/screens/Calendar/model/event.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  final List<Event> _events = [];
  List<Event> get events => _events;
  Locale? get locale => _locale;
  String data = 'null';
  bool searchCheck = false;
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  DateTime setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventOfSelectedDate => _events;
  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;
    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

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
