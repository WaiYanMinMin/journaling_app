import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journaling_app/src/provider/locale_provider.dart';
import 'package:journaling_app/src/screens/Calendar/utils.dart';
import 'package:provider/provider.dart';

import 'model/event.dart';

class EventEditingPage extends StatefulWidget {
  const EventEditingPage({Key? key, this.event}) : super(key: key);
  final Event? event;
  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  TextEditingController titlecontroller = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  late DateTime to;
  late DateTime from;

  @override
  void ondispose() {
    titlecontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      from = DateTime.now();
      to = DateTime.now().add(Duration(hours: 2));
    } else {
      final event = widget.event!;
      titlecontroller.text = event.title;
      from = event.from;
      to = event.to;
    }
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: new EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(
                height: 12,
              ),
              buildDatetimepicker(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
          border: UnderlineInputBorder(), hintText: "Add Title"),
      onFieldSubmitted: (_) {},
      validator: (title) =>
          title != null && title.isEmpty ? "Title cannot be empty" : null,
      controller: titlecontroller,
    );
  }

  Widget buildDatetimepicker() {
    return Column(
      children: [
        buildfromdate(),
        buildtodate(),
      ],
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

  Future picktodatetime({required bool pickdate}) async {
    final date = await pickDatetime(to,
        pickdate: pickdate, firstDate: pickdate ? from : null);

    if (date == null) return;

    setState(() {
      to = date;
    });
  }

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) {
    return ListTile(
      title: Text(text),
      trailing: Icon(Icons.arrow_drop_down),
      onTap: onClicked,
    );
  }

  Widget buildHeader({required String header, required Widget child}) {
    return Column(children: [
      Text(
        header,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      child
    ]);
  }

  List<Widget> buildEditingActions() => [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: saveForm,
            child: Icon(Icons.done))
      ];

  Future saveForm() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
          title: titlecontroller.text,
          description: "description",
          from: from,
          to: to,
          isAllDay: false);

      final isEditing = widget.event != null;
      final provider = Provider.of<LocaleProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, widget.event!);
      } else {
        provider.addEvent(event);
      }

      Get.back();
    }
  }
}
