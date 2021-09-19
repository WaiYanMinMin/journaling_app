import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';
import 'package:journaling_app/src/screens/Calendar/model/event_data_source.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  String? color;
  @override
  void initState() {
    super.initState();
    color = UserSimplePreferences.getColor();
  }

  late int primaryColor;
  late int secondaryColor;
  EventDao eventdao = Get.find();
  @override
  Widget build(BuildContext context) {
    if (color == 'blue') {
      secondaryColor = 0xff67A9A9;
      primaryColor = 0xff2B7279;
    } else if (color == 'green') {
      secondaryColor = 0xff30db2a;
      primaryColor = 0xff127a2e;
    } else {
      primaryColor = 0xffc3e02f;
      secondaryColor = 0xff607012;
    }
    final provider = Provider.of<LocaleProvider>(context);

    return StreamBuilder<List<Event>>(
        stream: eventdao.getAllEvent(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return SfCalendar(
              view: CalendarView.timelineDay,
              dataSource: EventDataSource(snapshot.data!),
              initialDisplayDate: provider.selectedDate,
              appointmentBuilder: appointmentBuilder,
              headerHeight: 0,
              /* onTap: (details) {
          if (details.appointments == null) return;
          final event = details.appointments!.first;
          Get.to(EventViewingPage(event: event));
        }, */
              todayHighlightColor: Colors.black,
            );
          }
          return Center(
            child: Text(
              "No events found.",
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          );
        });
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
        color: Color(secondaryColor).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
