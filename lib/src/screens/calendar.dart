import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/src/screens/Calendar/Event_editing_screen.dart';

import 'package:journaling_app/src/screens/Calendar/calender_widget.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
      secondaryColor = 0xffc3e02f;
      primaryColor = 0xff607012;
    }
    return Scaffold(
      backgroundColor: Color(primaryColor),
      body: CalenderWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Color(primaryColor),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(EventEditingScreen());
        },
      ),
    );
  }
}
