import 'package:floor/floor.dart';

import 'data.dart';

@dao
abstract class NoteDao {
  @Query('select * from note')
  Stream<List<Note>> getAllNotes();
  @Query('select * from note where title like :keyword')
  Stream<List<Note>> searchData(String keyword);
  @insert
  Future<void> addNote(Note note);
  @delete
  Future<void> deleteNote(Note note);
  @update
  Future<void> updateNote(Note note);
}

@dao
abstract class ProfileDao {
  @insert
  Future<void> createProfile(Profile profile);
  @Query('select * from profile')
  Stream<Profile?> getProfiledata();
  @update
  Future<void> updateProfile(Profile profile);
}

@dao
abstract class EventDao {
  @insert
  Future<void> addEvent(Event event);
  @Query('select * from event')
  Stream<List<Event>> getAllEvent();
}
