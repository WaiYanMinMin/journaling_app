import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';

import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/src/screens/home.dart';
import 'package:journaling_app/src/screens/update_story.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final String photo;
  final int selectedEmoji;
  final int selectedWeather;
  final String dueDate;
  DetailScreen(
      {required this.id,
      required this.title,
      required this.description,
      required this.photo,
      required this.selectedEmoji,
      required this.selectedWeather,
      required this.dueDate});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final NoteDao noteDao = Get.find();

  String? color;

  @override
  void initState() {
    super.initState();
    color = UserSimplePreferences.getColor();
  }

  @override
  Widget build(BuildContext context) {
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
    IconData getEmoji(int? selectIndex) {
      if (selectIndex == 0) {
        return FontAwesomeIcons.sadCry;
      } else if (selectIndex == 1) {
        return FontAwesomeIcons.angry;
      } else if (selectIndex == 2) {
        return FontAwesomeIcons.smile;
      } else {
        return FontAwesomeIcons.sadTear;
      }
    }

    IconData getWeather(int? selectedWeather) {
      if (selectedWeather == 0) {
        return FontAwesomeIcons.cloudRain;
      } else if (selectedWeather == 1) {
        return FontAwesomeIcons.sun;
      } else if (selectedWeather == 2) {
        return FontAwesomeIcons.snowflake;
      } else {
        return FontAwesomeIcons.cloudSun;
      }
      // FontAwesomeIcons.cloudRain,
      //   FontAwesomeIcons.sun,
      //   FontAwesomeIcons.snowflake,
      //   FontAwesomeIcons.cloudSun,
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(primaryColor),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  height: 70,
                  width: 50,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  widget.dueDate,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600), //date
                ),
              ]), //App Bar
              //second row
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.white12,
                  child: Text(
                    widget.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color(0xFFedd09f),
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: FaIcon(
                            getEmoji(widget.selectedEmoji),
                            size: 20,
                            color: Color(primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Center(
                              child: FaIcon(
                            getWeather(widget.selectedWeather),
                            color: Color(primaryColor),
                            size: 20,
                          ))),
                    ],
                  ), //weather and emoji
                ),
              ),
              (widget.photo != 'null')
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 10, bottom: 10, right: 15),
                      child: Container(
                          height: 155,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(widget.photo),
                                fit: BoxFit.fill,
                              ))))
                  : Center(),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.white12,
                  child: Text(
                    widget.description,
                    maxLines: 40,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70),
                  ),
                ),
              ),
              SizedBox(
                height: (widget.photo != 'null') ? 30 : 180,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          UpdateScreen(
                              title: widget.title,
                              id: widget.id,
                              description: widget.description,
                              photo: widget.photo,
                              dueDate: widget.dueDate,
                              emoji: widget.selectedEmoji,
                              weather: widget.selectedWeather),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white30,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Edit',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 19,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 38,
                    ),
                    GestureDetector(
                      onTap: () {
                        noteDao.deleteNote(
                          Note(
                            id: widget.id,
                            title: widget.title,
                            description: widget.description,
                            photo: widget.photo,
                            emoji: widget.selectedEmoji,
                            weather: widget.selectedWeather,
                            dueDate: widget.dueDate,
                          ),
                        );
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.redAccent,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Delete',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 19,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
