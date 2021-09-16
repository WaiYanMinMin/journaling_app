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

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _inProcess = false;
  Profile profile = Get.arguments;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  File? bgimage;
  File? profileimage;

  _EditProfileScreenState() {
    firstName.text = profile.firstName;
    lastName.text = profile.lastName;
    city.text = profile.city;
    country.text = profile.country;
    bgimage = File(profile.bgImage);
    profileimage = File(profile.profileImage);
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
            toolbarColor: Color(0xff2B7279),
            toolbarTitle: "Crop Image",
            statusBarColor: Color(0xff2B7279),
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
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Color(0xff2B7279),
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
                                    child: Image.file(
                                  bgimage!,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                )),
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
                                          color: Color(0xff67A9A9),
                                          size: 30,
                                        )),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff67A9A9),
                                          fontWeight: FontWeight.w500),
                                    )
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
                                              child: Image.file(
                                                profileimage!,
                                                fit: BoxFit.fill,
                                              ),
                                            )),
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
                                            (() {
                                              if (profile.language ==
                                                  "English") {
                                                return "First name";
                                              } else {
                                                return "မိမိနာမည်";
                                              }
                                            }()),
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
                                            hintText: (() {
                                              if (profile.language ==
                                                  "English") {
                                                return "Enter your first name";
                                              } else {
                                                return "မိမိနာမည်ထည့်ရန်";
                                              }
                                            }()),
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
                                            (() {
                                              if (profile.language ==
                                                  "English") {
                                                return "Last name";
                                              } else {
                                                return "မိသားစုမျိုးရိုးနာမည်";
                                              }
                                            }()),
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
                                            hintText: (() {
                                              if (profile.language ==
                                                  "English") {
                                                return "Enter your last name";
                                              } else {
                                                return "မိသားစုမျိုးရိုးနာမည်ထည့်ရန်";
                                              }
                                            }()),
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
                                            (() {
                                              if (profile.language ==
                                                  "English") {
                                                return "City";
                                              } else {
                                                return "မြို့";
                                              }
                                            }()),
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
                                            hintText: (() {
                                              if (profile.language ==
                                                  "English") {
                                                return "Enter your city name";
                                              } else {
                                                return "မြို့နာမည်ထည့်ရန်";
                                              }
                                            }()),
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
                                            (() {
                                              if (profile.language ==
                                                  "English") {
                                                return "Country";
                                              } else {
                                                return "နိုင်ငံ";
                                              }
                                            }()),
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
                                            hintText: (() {
                                              if (profile.language ==
                                                  "English") {
                                                return "Enter your country name";
                                              } else {
                                                return "နိုင်ငံနာမည်ထည့်ရန်";
                                              }
                                            }()),
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
                                                (() {
                                                  if (profile.language ==
                                                      "English") {
                                                    return "Cancel";
                                                  } else {
                                                    return "ပြန်ပြင်ရန်";
                                                  }
                                                }()),
                                                style: TextStyle(
                                                    color: Color(0xff67A9A9)),
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
                                                    (() {
                                                      if (profile.language ==
                                                          "English") {
                                                        return "Are you sure?";
                                                      } else {
                                                        return "သေချာပြီလား?";
                                                      }
                                                    }()),
                                                    firstName.text,
                                                    lastName.text,
                                                    city.text,
                                                    country.text,
                                                    bgimage?.path ?? "null",
                                                    profileimage?.path ??
                                                        "null",
                                                    profile.language);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Color(0xff67A9A9),
                                              ),
                                              child: Text(
                                                (() {
                                                  if (profile.language ==
                                                      "English") {
                                                    return "Save";
                                                  } else {
                                                    return "သိမ်းရန်";
                                                  }
                                                }()),
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
