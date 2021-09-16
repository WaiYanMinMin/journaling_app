import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/src/screens/Calendar/Event_Editing_Page.dart';

import 'package:journaling_app/src/screens/Calendar/calender_widget.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: CalenderWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(EventEditingPage());
        },
      ),
    ));
  }
}
