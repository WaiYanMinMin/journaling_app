import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';
import 'package:journaling_app/src/screens/Profile.dart';
import 'package:journaling_app/src/screens/calendar.dart';
import 'package:journaling_app/src/screens/create.dart';
import 'package:journaling_app/src/screens/home.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  

  int _page = 0;
  final screens = [
    HomeScreen(),
    CreateScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    
    ProfileDao profile = Get.find();

    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: 0,
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
          },
        ),
        body: StreamBuilder<Profile?>(
            stream: profile.getProfiledata(),
            builder: (_, data) {
              // return (() {
              //   if (data.data?.language == "မြန်မာ") {
              //     provider.setLocale(Locale('my'));
              //     return screens[_page];
              //   } else {
              //     return screens[_page];
              //   }
              // }());
              return screens[_page];
            }));
  }
}
