import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  static final keylanguage = 'en';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLanguage(String language) async {
      await _preferences.setString(keylanguage, language);
      print(keylanguage);
  }
  static String getLanguage() => _preferences.getString(keylanguage) ?? 'en';
}
