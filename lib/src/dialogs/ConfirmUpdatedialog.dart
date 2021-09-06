import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';

import 'package:journaling_app/src/screens/Profile.dart';

class ConfirmUpdatedialog {
  final ProfileDao profileDao = Get.find();
  confirmationUpdate(
      BuildContext context,
      String title,
      String firstname,
      String lastname,
      String city,
      String country,
      String bgImage,
      String profileImage) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
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
                  "Cancel",
                  style: TextStyle(color: Color(0xff67A9A9)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff67A9A9),
                ),
                onPressed: () {
                  profileDao.updateProfile(Profile(firstname, lastname, city,
                      country, bgImage, profileImage, 1));
<<<<<<< HEAD
                  Get.offAll(ProfileScreen());
=======
                  Get.to(ProfileScreen());
>>>>>>> d9ad3145057e6f81eebf84fbb0857675bc4a4aec
                }, //update data to database
                child: Text(
                  "Yes",
                ),
              )
            ],
          );
        });
  }
}
