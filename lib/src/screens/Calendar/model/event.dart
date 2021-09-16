import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundcolor;
  final bool isAllDay;

  Event({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundcolor = const Color(0xff67A9A9),
    this.isAllDay = false,
  });
}
