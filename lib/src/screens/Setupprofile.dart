import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:is_first_run/is_first_run.dart';

import 'package:journaling_app/src/dialogs/ConfirmSetupdialog.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({Key? key}) : super(key: key);

  @override
  _SetupProfileScreenState createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
   @override
  void dispose() {
    // TODO: implement dispose
    print("left");
    super.dispose();
  }
  File? bgimage;
  File? profileimage;
  ConfirmSetupdialog dialog = new ConfirmSetupdialog();
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
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.profileimage = imageTemp;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                            child: bgimage == null
                                ? Text("No image selected")
                                : Center(
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
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  "Setup Profile",
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
                                      width: 100,
                                      height: 100,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: profileimage == null
                                              ? Image.asset(
                                                  'assets/pngs/avatar.png',
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.file(profileimage!)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 100,
                                      child: Text(
                                        "First Name",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    margin: new EdgeInsets.only(right: 20),
                                    height: 50,
                                    width: 300,
                                    child: TextField(
                                        decoration: InputDecoration(
                                            fillColor: Color(0xffF1F1F1),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffCECECE),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(7.0)),
                                            hintText: 'Enter your first name'),
                                        controller: firstName),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                      width: 100,
                                      child: Text(
                                        "Last Name",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    margin: new EdgeInsets.only(right: 20),
                                    height: 50,
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          fillColor: Color(0xffF1F1F1),
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffCECECE),
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(7.0)),
                                          hintText: 'Enter your last name'),
                                      controller: lastName,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                      width: 100,
                                      child: Text(
                                        "Country",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    margin: new EdgeInsets.only(right: 20),
                                    height: 50,
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          fillColor: Color(0xffF1F1F1),
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffCECECE),
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(7.0)),
                                          hintText: 'Enter your country'),
                                      controller: country,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                      width: 100,
                                      child: Text(
                                        "City",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    margin: new EdgeInsets.only(right: 20),
                                    height: 50,
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          fillColor: Color(0xffF1F1F1),
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffCECECE),
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(7.0)),
                                          hintText: 'Enter your city'),
                                      controller: city,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    margin: new EdgeInsets.only(left: 130),
                                    child: Row(children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            dialog.confirmationSetup(
                                                context,
                                                "Are You Sure?",
                                                firstName.text,
                                                lastName.text,
                                                city.text,
                                                country.text,
                                                bgimage!.path,
                                                profileimage!.path);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xff67A9A9),
                                          ),
                                          child: Text("Save"),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ))
                        ],
                      ))))),
    ));
  }
}
