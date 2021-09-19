import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/database/data.dart';
import 'package:journaling_app/database/notedao.dart';

import 'package:journaling_app/src/provider/locale_provider.dart';

import 'package:journaling_app/src/screens/Calendar/model/event_data_source.dart';
import 'package:journaling_app/src/screens/Calendar/task_widget.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
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
      primaryColor = 0xffc3e02f;
      secondaryColor = 0xff607012;
    }
    EventDao eventdao = Get.find();

    return Padding(
      padding: const EdgeInsets.only(top:15.0,bottom: 15,left: 10,right: 10),
      child: StreamBuilder<List<Event>>(
          stream: eventdao.getAllEvent(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return SfCalendar(
                view: CalendarView.month,
                monthViewSettings:
                    MonthViewSettings(showTrailingAndLeadingDates: false),
                dataSource: EventDataSource(snapshot.data!),
                initialSelectedDate: DateTime.now(),
                todayHighlightColor: Color(secondaryColor),
                cellBorderColor: Colors.black,
                headerStyle: CalendarHeaderStyle(
                    textStyle: TextStyle(color: Colors.white)),
                onLongPress: (details) {
                  final provider =
                      Provider.of<LocaleProvider>(context, listen: false);
                  provider.setDate(details.date!);
                  showModalBottomSheet(
                      context: context, builder: (context) => TaskWidget());
                },
              );
            } else {
              return SfCalendar(
                view: CalendarView.month,
                monthViewSettings:
                    MonthViewSettings(showTrailingAndLeadingDates: false),
                initialSelectedDate: DateTime.now(),
                todayHighlightColor: Color(secondaryColor),
                cellBorderColor: Colors.black,
                headerStyle: CalendarHeaderStyle(
                    textStyle: TextStyle(color: Colors.white)),
                onLongPress: (details) {
                  final provider =
                      Provider.of<LocaleProvider>(context, listen: false);
                  provider.setDate(details.date!);
                  showModalBottomSheet(
                      context: context, builder: (context) => TaskWidget());
                },
              );
            }
          }),
    );
  }
}
