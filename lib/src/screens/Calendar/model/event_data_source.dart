import 'package:journaling_app/database/data.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }
  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => DateTime.parse(getEvent(index).todate);
  @override
  DateTime getEndTime(int index) => DateTime.parse(getEvent(index).fromdate);
  @override
  String getSubject(int index) => getEvent(index).title;
}
