import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';

import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/src/screens/home.dart';
import 'package:journaling_app/src/screens/update_story.dart';

class DetailScreen extends StatelessWidget {
  final NoteDao noteDao = Get.find();
  // Note note = Get.arguments;
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
  Widget build(BuildContext context) {
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
        backgroundColor: Color(0xFF2b7379),
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
                  dueDate,
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
                    title,
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
                            getEmoji(selectedEmoji),
                            size: 20,
                            color: Color(0xFF2b7379),
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
                            getWeather(selectedWeather),
                            color: Color(0xFF2b7379),
                            size: 20,
                          ))),
                    ],
                  ), //weather and emoji
                ),
              ),
              (photo != 'null')
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
                                File(photo),
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
                    description,
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
                height: (photo != 'null') ? 30 : 200,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        UpdateScreen(
                            title: title,
                            id: id,
                            description: description,
                            photo: photo,
                            dueDate: dueDate,
                            emoji: selectedEmoji,
                            weather: selectedWeather),
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
                    width: 48,
                  ),
                  GestureDetector(
                    onTap: () {
                      noteDao.deleteNote(
                        Note(
                          id: id,
                          title: title,
                          description: description,
                          photo: photo,
                          emoji: selectedEmoji,
                          weather: selectedWeather,
                          dueDate: dueDate,
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
            ],
          ),
        ),
      ),
    );
  }
}
