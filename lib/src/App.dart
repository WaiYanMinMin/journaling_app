import 'package:flutter/material.dart';

import 'package:journaling_app/src/screens/home.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomeScreen(),
    );
  }
}
