

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';

import 'package:journaling_app/src/screens/Profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ConfirmUpdatedialog {
  final ProfileDao profileDao = Get.find();
  
  confirmationUpdate(
      BuildContext context,
      String title,
      String color,
      String firstname,
      String lastname,
      String city,
      String country,
      String bgImage,
      String profileImage,
      String languagechosen) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          int primaryColor;
          int secondaryColor;
          if (color == 'blue') {
            secondaryColor = 0xff67A9A9;
            primaryColor = 0xff2B7279;
          } else if (color == 'green') {
            secondaryColor = 0xff30db2a;
            primaryColor = 0xff127a2e;
          } else {
            primaryColor = 0xffc3e02f;
            secondaryColor = 0xff607012;
          }
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text(title),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(
                  (() {
                    if (languagechosen == "English") {
                      return "Cancel";
                    } else {
                      return "ပြန်ပြင်ရန်";
                    }
                  }()),
                  style: TextStyle(color: Color(secondaryColor)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(secondaryColor),
                ),
                onPressed: () {
                  profileDao.updateProfile(Profile(firstname, lastname, city,
                      country, bgImage, profileImage, 1));

                  Get.close(2);
                }, //update data to database
                child: Text(
                  (() {
                    if (languagechosen == "English") {
                      return "Yes";
                    } else {
                      return "သေချာပြီ";
                    }
                  }()),
                ),
              )
            ],
          );
        });
  }
}
