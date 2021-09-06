import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
<<<<<<< HEAD
=======
import 'package:journaling_app/src/routers/router.gr.dart';
>>>>>>> d9ad3145057e6f81eebf84fbb0857675bc4a4aec
import 'package:journaling_app/src/screens/EditProfile.dart';

import 'package:journaling_app/src/screens/calendar.dart';
import 'package:journaling_app/src/screens/create.dart';
import 'package:journaling_app/src/screens/home.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _page = 0;
  String choseLanguage = "English";
  List<String> languages = ["Myanmar", "English"];
  @override
  Widget build(BuildContext context) {
    final ProfileDao profileDao = Get.find();

    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: 3,
          color: Color(0xff67A9A9),
          backgroundColor: Color(0xff2B7279),
          items: [
            Icon(
              FontAwesomeIcons.home,
              color: Colors.white,
            ),
            Icon(
              FontAwesomeIcons.plus,
              color: Colors.white,
            ),
            Icon(
              FontAwesomeIcons.calendarAlt,
              color: Colors.white,
            ),
            Icon(
              FontAwesomeIcons.userAlt,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });

            if (_page == 3) {
              Get.off(ProfileScreen());
            } else if (_page == 2) {
              Get.off(CalendarScreen());
            } else if (_page == 1) {
              Get.off(CreateScreen());
            } else {
              Get.off(HomeScreen());
            }
          },
        ),
        body: StreamBuilder<Profile?>(
            stream: profileDao.getProfiledata(),
            builder: (_, data) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // background image and bottom contents
                  Column(
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        child: Center(
                          child: data.hasData
                              ? Image.file(
                                  File(data.data!.bgImage),
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                )
                              : Text("Choose background image"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            color: Color(0xff2B7279),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                      child: data.hasData
                                          ? Text(
                                              data.data!.firstName +
                                                  " " +
                                                  data.data!.lastName,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              "add a name",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                ),
                                data.hasData
                                    ? Text(
                                        data.data!.city +
                                            "," +
                                            data.data!.country,
                                        style: TextStyle(color: Colors.white54),
                                      )
                                    : Text(
                                        'add city and country',
                                        style: TextStyle(color: Colors.white54),
                                      ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: new EdgeInsets.only(left: 40),
                                  width: double.infinity,
                                  child: Text(
                                    "Settings",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin:
                                      new EdgeInsets.only(left: 40, top: 30),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.globe,
                                        color: Colors.white,
                                      ),
                                      Container(
                                          margin: new EdgeInsets.only(left: 10),
                                          child: Text("Languages",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                      Container(
                                          margin:
                                              new EdgeInsets.only(left: 130),
                                          child: DropdownButton<String>(
                                            iconSize: 30,
                                            iconEnabledColor: Colors.white,
                                            iconDisabledColor: Colors.white54,
                                            value: choseLanguage,
                                            dropdownColor: Color(0xff67A9A9),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                choseLanguage = newValue!;
                                              });
                                            },
                                            items: languages
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) =>
                                                        DropdownMenuItem<
                                                                String>(
                                                            value: value,
                                                            child: Text(value,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ))))
                                                .toList(),
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      new EdgeInsets.only(left: 40, top: 30),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.globe,
                                        color: Colors.white,
                                      ),
                                      Container(
                                          margin: new EdgeInsets.only(left: 10),
                                          child: Text("Add",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                      Container(
                                          margin:
                                              new EdgeInsets.only(left: 130),
                                          child: Text("Something here",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ))),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xff67A9A9),
                                        ),
                                        margin: new EdgeInsets.only(left: 10),
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.arrow_forward_ios,
                                                color: Colors.white, size: 15)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: new EdgeInsets.only(top: 30),
                                    width: double.infinity,
                                    child: Container(
                                        margin: new EdgeInsets.only(left: 10),
                                        child: TextButton(
                                          style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "Erase all memories",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.red),
                                          ),
                                        ))),
                              ],
                            )),
                      )
                    ],
                  ),

                  // Profile image
                  Positioned(
                    top:
                        150.0, //(background container size) - (circle height / 2)
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: data.hasData
                              ? Image.file(
                                  File(data.data!.profileImage),
                                  fit: BoxFit.fill,
                                )
                              : Text("Choose image")),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 350,
                    child: Container(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        onPressed: () {
                          Get.to(EditProfileScreen(), arguments: data.data!);
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.edit,
                          size: 20,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
