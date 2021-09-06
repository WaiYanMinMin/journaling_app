
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:journaling_app/src/screens/Profile.dart';
import 'package:journaling_app/src/screens/create.dart';
import 'package:journaling_app/src/screens/home.dart';


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _page = 0;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: 2,
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
        body: MaterialApp(
            home: Container(
          color: Color(0xff2B7279),
          child: Text("Calendar"),
        )));
  }
}
