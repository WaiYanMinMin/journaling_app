import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/l10n/l10n.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';
import 'package:provider/provider.dart';

class LanguagePickerWidget extends StatefulWidget {
  late final String firstname;
  late final String lastname;
  late final String city;
  late final String country;
  late final String bgImage;
  late final String profileImage;
  LanguagePickerWidget(String firstname, String lastname, String city,
      String country, String bgImage, String profileImage) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.city = city;
    this.country = country;
    this.bgImage = bgImage;
    this.profileImage = profileImage;
  }

  @override
  _LanguagePickerWidgetState createState() => _LanguagePickerWidgetState();
}

class _LanguagePickerWidgetState extends State<LanguagePickerWidget> {
  String? statelocale;

  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('en');

    return DropdownButton(
      iconDisabledColor: Colors.white,
      iconEnabledColor: Colors.white,
      dropdownColor: Color(0xff2B7279),
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
