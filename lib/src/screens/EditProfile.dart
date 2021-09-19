import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:journaling_app/database/data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:journaling_app/src/dialogs/ConfirmUpdatedialog.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? color;
  @override
  void initState() {
    super.initState();
    color = UserSimplePreferences.getColor();
  }

  bool _inProcess = false;
  Profile profile = Get.arguments ?? Profile("", "", "", "", "null", "null", 1);

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  File? bgimage;
  File? profileimage;

  late int primaryColor;
  late int secondaryColor;
  double? sizedboxwidthmy = 20;
  double? sizedboxwidthen = 150;
  _EditProfileScreenState() {
    firstName.text = profile.firstName;
    lastName.text = profile.lastName;
    city.text = profile.city;
    country.text = profile.country;
    bgimage = ((() {
      if (profile.bgImage == "null") {
        return null;
      } else {
        return File(profile.bgImage);
      }
    }()));
    profileimage = ((() {
      if (profile.profileImage == "null") {
        return null;
      } else {
        return File(profile.profileImage);
      }
    }()));
  }
  ConfirmUpdatedialog dialog = new ConfirmUpdatedialog();
  Future pickBackGroundImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.bgimage = imageTemp;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future pickProfileImage() async {
    this.setState(() {
      _inProcess = true;
    });
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          maxWidth: 100,
          maxHeight: 100,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Color(primaryColor),
            toolbarTitle: "Crop Image",
            statusBarColor: Color(primaryColor),
            backgroundColor: Colors.white,
          ));
      final imageTemp = File(
        cropped?.path ?? "null",
      );
      if (imageTemp.path != "null") {
        setState(() {
          this.profileimage = imageTemp;
          _inProcess = false;
        });
      } else {
        _inProcess = false;
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Color(primaryColor),
          child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width,
                            minHeight: MediaQuery.of(context).size.height,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                height: 200.0,
                                child: Center(
                                    child: (() {
                                  if (bgimage == null) {
                                    return Image.asset("assets/pngs/bgnull.png",
                                        width: double.infinity,
                                        fit: BoxFit.fill);
                                  } else {
                                    return Image.file(bgimage!,
                                        width: double.infinity,
                                        fit: BoxFit.fill);
                                  }
                                }())),
                              ),
                              Container(
                                height: 200.0,
                                color: Colors.black45,
                                child: Center(
                                    child: Container(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    onPressed: () {
                                      pickBackGroundImage();
                                    },
                                    icon: Icon(Icons.add, size: 30),
                                  ),
                                )),
                              ),
                              Positioned(
                                top: 20,
                                left: 20,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.keyboard_arrow_left,
                                          color: Color(primaryColor),
                                          size: 30,
                                        )),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 150,
                                left: 150,
                                child: Container(
                                    width: 130,
                                    height: 100,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 100.0,
                                          width: 100.0,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: (() {
                                                if (profileimage == null) {
                                                  return Image.asset(
                                                      "assets/pngs/profile.png",
                                                      fit: BoxFit.fill);
                                                } else {
                                                  return Image.file(
                                                      profileimage!,
                                                      fit: BoxFit.fill);
                                                }
                                              }())),
                                        ),
                                        Positioned(
                                          right: 20,
                                          top: 70,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff76DBFB)),
                                            child: IconButton(
                                              onPressed: () {
                                                pickProfileImage();
                                              },
                                              icon: FaIcon(
                                                FontAwesomeIcons.camera,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              Positioned(
                                  top: 300,
                                  left: 30,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 25,
                                          width: 100,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                    ?.firstName ??
                                                "First Name",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          )),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        margin: new EdgeInsets.only(right: 20),
                                        height: 50,
                                        width: 300,
                                        child: TextField(
                                          style: TextStyle(height: 1.5),
                                          controller: firstName,
                                          decoration: InputDecoration(
                                            fillColor: Color(0xffF1F1F1),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffCECECE),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(7.0)),
                                            hintText:
                                                AppLocalizations.of(context)
                                                        ?.enterFirstName ??
                                                    "Enter your first name",
                                            hintStyle:
                                                TextStyle(fontSize: 15.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          height: 30,
                                          width: 300,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                    ?.lastName ??
                                                "Last Name",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          )),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        margin: new EdgeInsets.only(right: 20),
                                        height: 50,
                                        width: 300,
                                        child: TextField(
                                          style: TextStyle(height: 1.5),
                                          decoration: InputDecoration(
                                            fillColor: Color(0xffF1F1F1),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffCECECE),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(7.0)),
                                            hintText:
                                                AppLocalizations.of(context)
                                                        ?.enterLastName ??
                                                    "Enter Your Last Name",
                                            hintStyle:
                                                TextStyle(fontSize: 15.0),
                                          ),
                                          controller: lastName,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          height: 25,
                                          width: 100,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                    ?.city ??
                                                "City",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          )),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        margin: new EdgeInsets.only(right: 20),
                                        height: 50,
                                        width: 300,
                                        child: TextField(
                                          style: TextStyle(height: 1.5),
                                          decoration: InputDecoration(
                                            fillColor: Color(0xffF1F1F1),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffCECECE),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(7.0)),
                                            hintText:
                                                AppLocalizations.of(context)
                                                        ?.enterCity ??
                                                    "Enter your city",
                                            hintStyle:
                                                TextStyle(fontSize: 15.0),
                                          ),
                                          controller: country,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          height: 25,
                                          width: 100,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                    ?.country ??
                                                "Country",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          )),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        margin: new EdgeInsets.only(right: 20),
                                        height: 50,
                                        width: 300,
                                        child: TextField(
                                          style: TextStyle(height: 1.5),
                                          decoration: InputDecoration(
                                            fillColor: Color(0xffF1F1F1),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffCECECE),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(7.0)),
                                            hintText:
                                                AppLocalizations.of(context)
                                                        ?.enterCountry ??
                                                    "Enter your country",
                                            hintStyle:
                                                TextStyle(fontSize: 15.0),
                                          ),
                                          controller: city,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: new EdgeInsets.only(left: 130),
                                        child: Row(children: [
                                          Container(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                              ),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                        ?.cancel ??
                                                    "Cancel",
                                                style: TextStyle(
                                                    color:
                                                        Color(secondaryColor)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                dialog.confirmationUpdate(
                                                    context,
                                                    AppLocalizations.of(context)
                                                            ?.confirmsure ??
                                                        "Are You Sure?",
                                                    color ?? 'blue',
                                                    firstName.text,
                                                    lastName.text,
                                                    city.text,
                                                    country.text,
                                                    bgimage?.path ?? "null",
                                                    profileimage?.path ??
                                                        "null",
                                                    AppLocalizations.of(context)
                                                            ?.language ??
                                                        "english");
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Color(secondaryColor),
                                              ),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                        ?.save ??
                                                    "Save",
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ))
                            ],
                          ))))),
        ),
        (_inProcess)
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.95,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Center()
      ],
    ));
  }
}
