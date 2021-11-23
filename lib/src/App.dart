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
  @override
  void initState() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    super.initState();
    provider.setcolor(UserSimplePreferences.getColor());
  }

  int _page = 0;
  final screens = [
    HomeScreen(),
    CreateScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    String? color;

    final provider = Provider.of<LocaleProvider>(context, listen: false);
    color = provider.getcolor();
    int primaryColor = 0xff2B7279;
    int secondaryColor = 0xff67A9A9;
    setState(() {
      if (color == 'blue') {
        secondaryColor = 0xff67A9A9;
        primaryColor = 0xff2B7279;
      } else if (color == 'green') {
        secondaryColor = 0xff30db2a;
        primaryColor = 0xff127a2e;
      } else {
        secondaryColor = 0xffc3e02f;
        primaryColor = 0xff607012;
      }
    });

    ProfileDao profile = Get.find();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          color: Color(secondaryColor),
          backgroundColor: Color(primaryColor),
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
        body: screens[_page]);
  }
}
