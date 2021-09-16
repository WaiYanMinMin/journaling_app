import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:journaling_app/src/screens/onboardingscreens/onboardingscreen.dart';

import 'database/note_database.dart';
import 'l2n/l2n.dart';
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
      print(ifr);
      _isFirstRun = ifr;
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkFirstRun();
    supportedLocales:L2n.all;
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
          return AnimatedSplashScreen(
            splash: Text("Journaling App"),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Color(0xff2B7279),
            nextScreen: Container(),
          );
        }
      },
    ));
  }
}
