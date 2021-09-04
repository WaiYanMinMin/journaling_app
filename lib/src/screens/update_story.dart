import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final NoteDao noteDao = Get.find();
  Note note = Get.arguments;

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

  //final int id = 1;
  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController descriptioncontroller = TextEditingController();

    titlecontroller.text = note.title;

    descriptioncontroller.text = note.description;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Screen'),
      ),
      body: Column(
        children: [
          TextField(
            controller: titlecontroller,
          ),
          TextField(
            controller: descriptioncontroller,
          ),
          Icon(
            getEmoji(note.emoji),
          ),
          Icon(
            getWeather(note.weather),
          ),
          Text(note.dueDate),
          ElevatedButton(
            onPressed: () {
              // Navigator.pop(context);
              noteDao.updateNote(
                Note(
                  title: titlecontroller.text,
                  description: descriptioncontroller.text,
                  photo: '',
                  emoji: note.emoji,
                  weather: note.weather,
                  dueDate: note.dueDate,
                  id: note.id,
                ),
              );
            },
            child: Center(
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
