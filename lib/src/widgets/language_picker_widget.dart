import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/l10n/l10n.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';
import 'package:provider/provider.dart';

class LanguagePickerWidget extends StatefulWidget {
  @override
  _LanguagePickerWidgetState createState() => _LanguagePickerWidgetState();
}

class _LanguagePickerWidgetState extends State<LanguagePickerWidget> {
  @override
  void initState() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    super.initState();
    provider.setcolor(UserSimplePreferences.getColor());
  }

  String? statelocale;

  @override
  Widget build(BuildContext context) {
    String? color;
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    color = provider.getcolor();
    final locale = provider.locale ?? Locale('en');
    int primaryColor;
    int secondaryColor;
    if (color == 'blue') {
      secondaryColor = 0xff67A9A9;
      primaryColor = 0xff2B7279;
    } else if (color == 'green') {
      secondaryColor = 0xff30db2a;
      primaryColor = 0xff127a2e;
    } else {
      secondaryColor = 0xffc3e02f;
      primaryColor = 0xff607012;
    }
    return DropdownButton(
      iconDisabledColor: Colors.white,
      iconEnabledColor: Colors.white,
      dropdownColor: Color(primaryColor),
      value: locale,
      items: L10n.all.map(
        (locale) {
          final languageChosen = L10n.getLanguage(locale.languageCode);
          return DropdownMenuItem(
            child: Center(
              child: Text(
                languageChosen,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            value: locale,
            onTap: () async {
              final provider =
                  Provider.of<LocaleProvider>(context, listen: false);
              provider.setLocale(locale);

              // profileDao.updateProfile(Profile(
              //     widget.firstname,
              //     widget.lastname,
              //     widget.city,
              //     widget.country,
              //     widget.bgImage,
              //     widget.profileImage,
              //     1,
              //     statelocale ?? "English"));
            },
          );
        },
      ).toList(),
      onChanged: (_) {},
    );
  }
}
