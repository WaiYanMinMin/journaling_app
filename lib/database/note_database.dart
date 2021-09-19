import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

import 'data.dart';
import 'notedao.dart';
part 'note_database.g.dart';

@Database(version: 1, entities: [Note,Profile,Event])
abstract class NoteDatabase extends FloorDatabase {
  NoteDao get noteDao;
  ProfileDao get profileDao;
  EventDao get eventDao;
}
