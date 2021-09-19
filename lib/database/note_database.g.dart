// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorNoteDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NoteDatabaseBuilder databaseBuilder(String name) =>
      _$NoteDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NoteDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$NoteDatabaseBuilder(null);
}

class _$NoteDatabaseBuilder {
  _$NoteDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$NoteDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$NoteDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<NoteDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$NoteDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$NoteDatabase extends NoteDatabase {
  _$NoteDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  ProfileDao? _profileDaoInstance;

  EventDao? _eventDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `photo` TEXT NOT NULL, `emoji` INTEGER NOT NULL, `weather` INTEGER NOT NULL, `dueDate` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `profile` (`id` INTEGER, `profiletitle` TEXT NOT NULL, `lastName` TEXT NOT NULL, `city` TEXT NOT NULL, `country` TEXT NOT NULL, `bgImage` TEXT NOT NULL, `profileImage` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `event` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `eventtitle` TEXT NOT NULL, `fromdate` TEXT NOT NULL, `todate` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }

  @override
  ProfileDao get profileDao {
    return _profileDaoInstance ??= _$ProfileDao(database, changeListener);
  }

  @override
  EventDao get eventDao {
    return _eventDaoInstance ??= _$EventDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'note',
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'photo': item.photo,
                  'emoji': item.emoji,
                  'weather': item.weather,
                  'dueDate': item.dueDate
                },
            changeListener),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'photo': item.photo,
                  'emoji': item.emoji,
                  'weather': item.weather,
                  'dueDate': item.dueDate
                },
            changeListener),
        _noteDeletionAdapter = DeletionAdapter(
            database,
            'note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'photo': item.photo,
                  'emoji': item.emoji,
                  'weather': item.weather,
                  'dueDate': item.dueDate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  final DeletionAdapter<Note> _noteDeletionAdapter;

  @override
  Stream<List<Note>> getAllNotes() {
    return _queryAdapter.queryListStream('select * from note',
        mapper: (Map<String, Object?> row) => Note(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            photo: row['photo'] as String,
            emoji: row['emoji'] as int,
            weather: row['weather'] as int,
            dueDate: row['dueDate'] as String),
        queryableName: 'note',
        isView: false);
  }

  @override
  Stream<List<Note>> searchData(String keyword) {
    return _queryAdapter.queryListStream(
        'select * from note where title like ?1',
        mapper: (Map<String, Object?> row) => Note(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            photo: row['photo'] as String,
            emoji: row['emoji'] as int,
            weather: row['weather'] as int,
            dueDate: row['dueDate'] as String),
        arguments: [keyword],
        queryableName: 'note',
        isView: false);
  }

  @override
  Future<void> addNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(Note note) async {
    await _noteUpdateAdapter.update(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNote(Note note) async {
    await _noteDeletionAdapter.delete(note);
  }
}

class _$ProfileDao extends ProfileDao {
  _$ProfileDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _profileInsertionAdapter = InsertionAdapter(
            database,
            'profile',
            (Profile item) => <String, Object?>{
                  'id': item.id,
                  'profiletitle': item.firstName,
                  'lastName': item.lastName,
                  'city': item.city,
                  'country': item.country,
                  'bgImage': item.bgImage,
                  'profileImage': item.profileImage
                },
            changeListener),
        _profileUpdateAdapter = UpdateAdapter(
            database,
            'profile',
            ['id'],
            (Profile item) => <String, Object?>{
                  'id': item.id,
                  'profiletitle': item.firstName,
                  'lastName': item.lastName,
                  'city': item.city,
                  'country': item.country,
                  'bgImage': item.bgImage,
                  'profileImage': item.profileImage
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Profile> _profileInsertionAdapter;

  final UpdateAdapter<Profile> _profileUpdateAdapter;

  @override
  Stream<Profile?> getProfiledata() {
    return _queryAdapter.queryStream('select * from profile',
        mapper: (Map<String, Object?> row) => Profile(
            row['profiletitle'] as String,
            row['lastName'] as String,
            row['city'] as String,
            row['country'] as String,
            row['bgImage'] as String,
            row['profileImage'] as String,
            row['id'] as int?),
        queryableName: 'profile',
        isView: false);
  }

  @override
  Future<void> createProfile(Profile profile) async {
    await _profileInsertionAdapter.insert(profile, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    await _profileUpdateAdapter.update(profile, OnConflictStrategy.abort);
  }
}

class _$EventDao extends EventDao {
  _$EventDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _eventInsertionAdapter = InsertionAdapter(
            database,
            'event',
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'eventtitle': item.title,
                  'fromdate': item.fromdate,
                  'todate': item.todate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Event> _eventInsertionAdapter;

  @override
  Stream<List<Event>> getAllEvent() {
    return _queryAdapter.queryListStream('select * from event',
        mapper: (Map<String, Object?> row) => Event(
            title: row['eventtitle'] as String,
            fromdate: row['fromdate'] as String,
            todate: row['todate'] as String,
            id: row['id'] as int?),
        queryableName: 'event',
        isView: false);
  }

  @override
  Future<void> addEvent(Event event) async {
    await _eventInsertionAdapter.insert(event, OnConflictStrategy.abort);
  }
}
