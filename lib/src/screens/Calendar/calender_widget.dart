import 'package:flutter/material.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';
import 'package:journaling_app/src/screens/Calendar/model/event_data_source.dart';
import 'package:journaling_app/src/screens/Calendar/task_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<LocaleProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      todayHighlightColor: Color(0xFF2b7379),
      cellBorderColor: Color(0xFF2b7379),
      onLongPress: (details) {
        final provider = Provider.of<LocaleProvider>(context, listen: false);
        provider.setDate(details.date!);
        showModalBottomSheet(
            context: context, builder: (context) => TaskWidget());
      },
    );
  }
}
