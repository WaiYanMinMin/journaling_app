import 'package:journaling_app/src/screens/Calendar/model/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
class EventDataSource extends CalendarDataSource{
  EventDataSource(List<Event> Appointments){
    this.appointments=appointments;
  }
  Event getEvent(int index) =>appointments![index] as Event;

  @override
  DateTime getStartTime(int index)=> getEvent(index).from;
  @override
  DateTime getEndTime(int index)=> getEvent(index).to;
  @override
  String getSubject(int index)=> getEvent(index).title;
  @override
  Color getColor(int index)=> getEvent(index).backgroundcolor;
  @override
  bool isAllDay(int index)=> getEvent(index).isAllDay;
}