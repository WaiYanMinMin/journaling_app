import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';

import 'database/note_database.dart';
import 'src/App.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: FutureBuilder<NoteDatabase>(
      future: $FloorNoteDatabase.databaseBuilder('note.db').build(),
      builder: (context, data) {
        if (data.hasData) {
          Get.put(data.data!.noteDao);
          return MyApp();
        } else if (data.hasError) {
          return Text('${data.error}');
        } else {
          return Text('Loading');
        }
      },
    ));
  }
}
