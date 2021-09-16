
import 'package:flutter/material.dart';



class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MaterialApp(
            home: Container(
          color: Color(0xff2B7279),
          child: Text("Calendar"),
        )));
  }
}
