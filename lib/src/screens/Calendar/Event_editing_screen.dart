import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:journaling_app/database/data.dart';

import 'package:journaling_app/database/notedao.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';

import 'package:journaling_app/src/screens/Calendar/utils.dart';
import 'package:journaling_app/src/screens/utils/user_simple_preference.dart';
import 'package:provider/provider.dart';

class EventEditingScreen extends StatefulWidget {
  const EventEditingScreen({Key? key, this.event}) : super(key: key);
  final Event? event;
  @override
  _EventEditingScreenState createState() => _EventEditingScreenState();
}

class _EventEditingScreenState extends State<EventEditingScreen> {
  String? color;
  @override
  void initState() {
    super.initState();
    color = UserSimplePreferences.getColor();
  }

  TextEditingController titlecontroller = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime to = DateTime.now().add(Duration(hours: 2));
  DateTime from = DateTime.now();

  EventDao eventDao = Get.find();
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
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(primaryColor),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Color(primaryColor),
        leading: BackButton(),
        actions: [
          IconButton(
              onPressed: () {
                String strtotime = DateFormat("yyyy-MM-dd hh:mm:ss").format(to);
                String strfromtime =
                    DateFormat("yyyy-MM-dd hh:mm:ss").format(from);

                DateTime testdate = DateTime.parse(strfromtime);
                print(testdate);
                final event = Event(
                  title: titlecontroller.text,
                  todate: strtotime,
                  fromdate: strfromtime,
                );
                /* final provider =
                    Provider.of<LocaleProvider>(context, listen: false); */
                /* provider.addEvent(event); */
                eventDao.addEvent(event);
                Get.back();
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "Title",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                fillColor: Color(0xffF1F1F1),
                filled: true,
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xffCECECE), width: 2.0),
                    borderRadius: BorderRadius.circular(7.0)),
                hintText: "Enter your title",
                hintStyle: TextStyle(fontSize: 15.0),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(height: 80, child: buildfromdate()),
            SizedBox(
              height: 30,
            ),
            Container(height: 80, child: buildtodate()),
          ],
        ),
      ),
    );
  }

  Widget buildfromdate() {
    return buildHeader(
      header: 'From',
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildDropdownField(
              text: Utils.toDate(from),
              onClicked: () {
                pickfromdatetime(pickdate: true);
              },
            ),
          ),
          Expanded(
            child: buildDropdownField(
              text: Utils.toTime(from),
              onClicked: () {
                pickfromdatetime(pickdate: false);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildtodate() {
    return buildHeader(
      header: 'To',
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildDropdownField(
              text: Utils.toDate(to),
              onClicked: () {
                picktodatetime(pickdate: true);
              },
            ),
          ),
          Expanded(
            child: buildDropdownField(
              text: Utils.toTime(to),
              onClicked: () {
                picktodatetime(pickdate: false);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildHeader({required String header, required Widget child}) {
    return Column(children: [
      Text(
        header,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
      child
    ]);
  }

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
      onTap: onClicked,
    );
  }

  Future pickfromdatetime({required bool pickdate}) async {
    final date = await pickDatetime(from, pickdate: pickdate);

    if (date == null) return;

    if (date.isAfter(to)) {
      to = DateTime(date.year, date.month, date.day, to.hour, to.minute);
    }
    setState(() {
      from = date;
    });
  }

  Future picktodatetime({required bool pickdate}) async {
    final date = await pickDatetime(to,
        pickdate: pickdate, firstDate: pickdate ? from : null);

    if (date == null) return;

    setState(() {
      to = date;
    });
  }

  Future<DateTime?> pickDatetime(
    DateTime initialDate, {
    required bool pickdate,
    DateTime? firstDate,
  }) async {
    if (pickdate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2102));
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeofday = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeofday == null) return null;
      final date = DateTime(
        initialDate.year,
        initialDate.month,
        initialDate.day,
      );
      final time = Duration(hours: timeofday.hour, minutes: timeofday.minute);
      return date.add(time);
    }
  }
}
