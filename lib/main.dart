import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:journaling_app/src/screens/BuildProvider.dart';
import 'package:journaling_app/src/screens/calendar.dart';
import 'package:journaling_app/src/screens/onboardingscreens/onboardingscreen.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';

import 'database/note_database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await UserSimplePreferences.init();
  runApp(CalendarScreen());
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
          return BuildProvider();
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

