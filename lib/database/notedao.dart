import 'package:floor/floor.dart';

import 'data.dart';

@dao
abstract class NoteDao {
  @Query('select * from note')
  Stream<List<Note>> getAllNotes();
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
