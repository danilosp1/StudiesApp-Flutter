// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DisciplineDao? _disciplineDaoInstance;

  TaskDao? _taskDaoInstance;

  MaterialLinkDao? _materialLinkDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `disciplines` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `location` TEXT, `professor` TEXT, `imageUri` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `subject_schedules` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `disciplineId` INTEGER NOT NULL, `dayOfWeek` TEXT NOT NULL, `startTime` TEXT NOT NULL, `endTime` TEXT NOT NULL, FOREIGN KEY (`disciplineId`) REFERENCES `disciplines` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tasks` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `disciplineId` INTEGER, `name` TEXT NOT NULL, `description` TEXT, `dueDate` TEXT, `dueTime` TEXT, `isCompleted` INTEGER NOT NULL, FOREIGN KEY (`disciplineId`) REFERENCES `disciplines` (`id`) ON UPDATE NO ACTION ON DELETE SET NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `material_links` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `disciplineId` INTEGER NOT NULL, `url` TEXT NOT NULL, `description` TEXT, FOREIGN KEY (`disciplineId`) REFERENCES `disciplines` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE INDEX `index_subject_schedules_disciplineId` ON `subject_schedules` (`disciplineId`)');
        await database.execute(
            'CREATE INDEX `index_tasks_disciplineId` ON `tasks` (`disciplineId`)');
        await database.execute(
            'CREATE INDEX `index_material_links_disciplineId` ON `material_links` (`disciplineId`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DisciplineDao get disciplineDao {
    return _disciplineDaoInstance ??= _$DisciplineDao(database, changeListener);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }

  @override
  MaterialLinkDao get materialLinkDao {
    return _materialLinkDaoInstance ??=
        _$MaterialLinkDao(database, changeListener);
  }
}

class _$DisciplineDao extends DisciplineDao {
  _$DisciplineDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _disciplineEntityInsertionAdapter = InsertionAdapter(
            database,
            'disciplines',
            (DisciplineEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'location': item.location,
                  'professor': item.professor,
                  'imageUri': item.imageUri
                },
            changeListener),
        _subjectScheduleEntityInsertionAdapter = InsertionAdapter(
            database,
            'subject_schedules',
            (SubjectScheduleEntity item) => <String, Object?>{
                  'id': item.id,
                  'disciplineId': item.disciplineId,
                  'dayOfWeek': item.dayOfWeek,
                  'startTime': item.startTime,
                  'endTime': item.endTime
                },
            changeListener),
        _disciplineEntityUpdateAdapter = UpdateAdapter(
            database,
            'disciplines',
            ['id'],
            (DisciplineEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'location': item.location,
                  'professor': item.professor,
                  'imageUri': item.imageUri
                },
            changeListener),
        _disciplineEntityDeletionAdapter = DeletionAdapter(
            database,
            'disciplines',
            ['id'],
            (DisciplineEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'location': item.location,
                  'professor': item.professor,
                  'imageUri': item.imageUri
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DisciplineEntity> _disciplineEntityInsertionAdapter;

  final InsertionAdapter<SubjectScheduleEntity>
      _subjectScheduleEntityInsertionAdapter;

  final UpdateAdapter<DisciplineEntity> _disciplineEntityUpdateAdapter;

  final DeletionAdapter<DisciplineEntity> _disciplineEntityDeletionAdapter;

  @override
  Stream<List<DisciplineEntity>> getAllDisciplinesAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM disciplines ORDER BY name ASC',
        mapper: (Map<String, Object?> row) => DisciplineEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            location: row['location'] as String?,
            professor: row['professor'] as String?,
            imageUri: row['imageUri'] as String?),
        queryableName: 'disciplines',
        isView: false);
  }

  @override
  Stream<DisciplineEntity?> findDisciplineByIdAsStream(int id) {
    return _queryAdapter.queryStream('SELECT * FROM disciplines WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DisciplineEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            location: row['location'] as String?,
            professor: row['professor'] as String?,
            imageUri: row['imageUri'] as String?),
        arguments: [id],
        queryableName: 'disciplines',
        isView: false);
  }

  @override
  Stream<List<SubjectScheduleEntity>> findSchedulesForDisciplineAsStream(
      int disciplineId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM subject_schedules WHERE disciplineId = ?1',
        mapper: (Map<String, Object?> row) => SubjectScheduleEntity(
            id: row['id'] as int?,
            disciplineId: row['disciplineId'] as int,
            dayOfWeek: row['dayOfWeek'] as String,
            startTime: row['startTime'] as String,
            endTime: row['endTime'] as String),
        arguments: [disciplineId],
        queryableName: 'subject_schedules',
        isView: false);
  }

  @override
  Future<int> insertDiscipline(DisciplineEntity discipline) {
    return _disciplineEntityInsertionAdapter.insertAndReturnId(
        discipline, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertSchedules(List<SubjectScheduleEntity> schedules) async {
    await _subjectScheduleEntityInsertionAdapter.insertList(
        schedules, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDiscipline(DisciplineEntity discipline) async {
    await _disciplineEntityUpdateAdapter.update(
        discipline, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDiscipline(DisciplineEntity discipline) async {
    await _disciplineEntityDeletionAdapter.delete(discipline);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _taskEntityInsertionAdapter = InsertionAdapter(
            database,
            'tasks',
            (TaskEntity item) => <String, Object?>{
                  'id': item.id,
                  'disciplineId': item.disciplineId,
                  'name': item.name,
                  'description': item.description,
                  'dueDate': item.dueDate,
                  'dueTime': item.dueTime,
                  'isCompleted': item.isCompleted ? 1 : 0
                },
            changeListener),
        _taskEntityUpdateAdapter = UpdateAdapter(
            database,
            'tasks',
            ['id'],
            (TaskEntity item) => <String, Object?>{
                  'id': item.id,
                  'disciplineId': item.disciplineId,
                  'name': item.name,
                  'description': item.description,
                  'dueDate': item.dueDate,
                  'dueTime': item.dueTime,
                  'isCompleted': item.isCompleted ? 1 : 0
                },
            changeListener),
        _taskEntityDeletionAdapter = DeletionAdapter(
            database,
            'tasks',
            ['id'],
            (TaskEntity item) => <String, Object?>{
                  'id': item.id,
                  'disciplineId': item.disciplineId,
                  'name': item.name,
                  'description': item.description,
                  'dueDate': item.dueDate,
                  'dueTime': item.dueTime,
                  'isCompleted': item.isCompleted ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TaskEntity> _taskEntityInsertionAdapter;

  final UpdateAdapter<TaskEntity> _taskEntityUpdateAdapter;

  final DeletionAdapter<TaskEntity> _taskEntityDeletionAdapter;

  @override
  Stream<TaskEntity?> findTaskByIdAsStream(int id) {
    return _queryAdapter.queryStream('SELECT * FROM tasks WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TaskEntity(
            id: row['id'] as int?,
            disciplineId: row['disciplineId'] as int?,
            name: row['name'] as String,
            description: row['description'] as String?,
            dueDate: row['dueDate'] as String?,
            dueTime: row['dueTime'] as String?,
            isCompleted: (row['isCompleted'] as int) != 0),
        arguments: [id],
        queryableName: 'tasks',
        isView: false);
  }

  @override
  Stream<List<TaskEntity>> getAllTasksAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM tasks ORDER BY dueDate ASC, dueTime ASC',
        mapper: (Map<String, Object?> row) => TaskEntity(
            id: row['id'] as int?,
            disciplineId: row['disciplineId'] as int?,
            name: row['name'] as String,
            description: row['description'] as String?,
            dueDate: row['dueDate'] as String?,
            dueTime: row['dueTime'] as String?,
            isCompleted: (row['isCompleted'] as int) != 0),
        queryableName: 'tasks',
        isView: false);
  }

  @override
  Stream<List<TaskEntity>> getTasksByDisciplineAsStream(int disciplineId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM tasks WHERE disciplineId = ?1 ORDER BY dueDate ASC, dueTime ASC',
        mapper: (Map<String, Object?> row) => TaskEntity(
            id: row['id'] as int?,
            disciplineId: row['disciplineId'] as int?,
            name: row['name'] as String,
            description: row['description'] as String?,
            dueDate: row['dueDate'] as String?,
            dueTime: row['dueTime'] as String?,
            isCompleted: (row['isCompleted'] as int) != 0),
        arguments: [disciplineId],
        queryableName: 'tasks',
        isView: false);
  }

  @override
  Stream<List<TaskEntity>> getPendingTasksAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM tasks WHERE isCompleted = 0 ORDER BY dueDate ASC, dueTime ASC',
        mapper: (Map<String, Object?> row) => TaskEntity(
            id: row['id'] as int?,
            disciplineId: row['disciplineId'] as int?,
            name: row['name'] as String,
            description: row['description'] as String?,
            dueDate: row['dueDate'] as String?,
            dueTime: row['dueTime'] as String?,
            isCompleted: (row['isCompleted'] as int) != 0),
        queryableName: 'tasks',
        isView: false);
  }

  @override
  Future<int> insertTask(TaskEntity task) {
    return _taskEntityInsertionAdapter.insertAndReturnId(
        task, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await _taskEntityUpdateAdapter.update(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTask(TaskEntity task) async {
    await _taskEntityDeletionAdapter.delete(task);
  }
}

class _$MaterialLinkDao extends MaterialLinkDao {
  _$MaterialLinkDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _materialLinkEntityInsertionAdapter = InsertionAdapter(
            database,
            'material_links',
            (MaterialLinkEntity item) => <String, Object?>{
                  'id': item.id,
                  'disciplineId': item.disciplineId,
                  'url': item.url,
                  'description': item.description
                },
            changeListener),
        _materialLinkEntityUpdateAdapter = UpdateAdapter(
            database,
            'material_links',
            ['id'],
            (MaterialLinkEntity item) => <String, Object?>{
                  'id': item.id,
                  'disciplineId': item.disciplineId,
                  'url': item.url,
                  'description': item.description
                },
            changeListener),
        _materialLinkEntityDeletionAdapter = DeletionAdapter(
            database,
            'material_links',
            ['id'],
            (MaterialLinkEntity item) => <String, Object?>{
                  'id': item.id,
                  'disciplineId': item.disciplineId,
                  'url': item.url,
                  'description': item.description
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MaterialLinkEntity>
      _materialLinkEntityInsertionAdapter;

  final UpdateAdapter<MaterialLinkEntity> _materialLinkEntityUpdateAdapter;

  final DeletionAdapter<MaterialLinkEntity> _materialLinkEntityDeletionAdapter;

  @override
  Stream<List<MaterialLinkEntity>> getMaterialLinksByDisciplineAsStream(
      int disciplineId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM material_links WHERE disciplineId = ?1 ORDER BY id ASC',
        mapper: (Map<String, Object?> row) => MaterialLinkEntity(
            id: row['id'] as int?,
            disciplineId: row['disciplineId'] as int,
            url: row['url'] as String,
            description: row['description'] as String?),
        arguments: [disciplineId],
        queryableName: 'material_links',
        isView: false);
  }

  @override
  Stream<MaterialLinkEntity?> getMaterialLinkByIdAsStream(int linkId) {
    return _queryAdapter.queryStream(
        'SELECT * FROM material_links WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MaterialLinkEntity(
            id: row['id'] as int?,
            disciplineId: row['disciplineId'] as int,
            url: row['url'] as String,
            description: row['description'] as String?),
        arguments: [linkId],
        queryableName: 'material_links',
        isView: false);
  }

  @override
  Future<void> insertMaterialLink(MaterialLinkEntity materialLink) async {
    await _materialLinkEntityInsertionAdapter.insert(
        materialLink, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateMaterialLink(MaterialLinkEntity materialLink) async {
    await _materialLinkEntityUpdateAdapter.update(
        materialLink, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMaterialLink(MaterialLinkEntity materialLink) async {
    await _materialLinkEntityDeletionAdapter.delete(materialLink);
  }
}
