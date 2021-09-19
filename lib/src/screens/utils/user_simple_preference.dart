import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  static final keylanguage = 'en';
  static final keycolor = "blue";
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setColor(String color) async {
    await _preferences.setString(keycolor, color);
  }

  static String getColor() => _preferences.getString(keycolor) ?? 'blue';
  static Future setLanguage(String language) async {
    await _preferences.setString(keylanguage, language);
    print(keylanguage);
  }

  static String getLanguage() => _preferences.getString(keylanguage) ?? 'en';
}
