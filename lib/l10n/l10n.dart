import 'package:flutter/material.dart';

class L10n {
  static final all = {const Locale('en'), const Locale('my')};
  static String getLanguage(String code) {
    switch (code) {
      case 'my':
        return 'Myanmar';
      case 'en':
        return 'English';
      default:
        return 'en';
    }
  }
}
