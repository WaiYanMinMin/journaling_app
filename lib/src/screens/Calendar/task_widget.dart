import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';
import 'package:journaling_app/src/screens/Calendar/model/event_data_source.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final selectedEvents = provider.eventOfSelectedDate;
    if (selectedEvents.isEmpty) {
      return Center(
        child: Text(
          "No events found.",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }
    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(provider.events),
      initialDisplayDate: provider.selectedDate,
      appointmentBuilder: appointmentBuilder,
      headerHeight: 0,
      onTap: (details) {
        if (details.appointments == null) return;
        final event = details.appointments!.first;
        Get.to(EventViewingPage(event: event));
      },
      todayHighlightColor: Colors.black,
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundcolor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
