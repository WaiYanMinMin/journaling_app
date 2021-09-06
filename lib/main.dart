import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:journaling_app/src/screens/Setupprofile.dart';
import 'package:journaling_app/src/screens/onboardingscreens/startscreen.dart';

import 'database/note_database.dart';
import 'src/App.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool? _isFirstRun;

  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      _isFirstRun = ifr;
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkFirstRun();

    return GetMaterialApp(
        home: FutureBuilder<NoteDatabase>(
      future: $FloorNoteDatabase.databaseBuilder('note.db').build(),
      builder: (context, data) {
        if (data.hasData) {
          Get.put(data.data!.noteDao);
          Get.put(data.data!.profileDao);
          if (_isFirstRun == true) {
            return StartScreen();
          }
          return MyApp();
        } else if (data.hasError) {
          return Text('${data.error}');
        } else {
          return Text('Loading');
        }
      },
    ));
  }
}
