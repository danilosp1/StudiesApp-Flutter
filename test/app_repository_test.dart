import 'package:flutter_test/flutter_test.dart';
import 'package:studies_app_flutter/data/app_database.dart';
import 'package:studies_app_flutter/data/models/discipline_entity.dart';
import 'package:studies_app_flutter/data/models/task_entity.dart';
import 'package:studies_app_flutter/data/remote/api_service.dart';
import 'package:studies_app_flutter/data/repository/app_repository.dart';
import 'package:mockito/mockito.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('AppRepository', () {
    late AppDatabase database;
    late AppRepository repository;
    late MockApiService mockApiService;

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
      mockApiService = MockApiService();
      repository = AppRepository(
        database.disciplineDao,
        database.taskDao,
        database.materialLinkDao,
        mockApiService,
      );
    });

    tearDown(() async {
      await database.close();
    });

    test('insert and get disciplines', () async {
      final discipline = DisciplineEntity(name: 'Math');
      await repository.insertDisciplineWithSchedules(discipline, []);

      final disciplines = await repository.getAllDisciplines().first;
      expect(disciplines.length, 1);
      expect(disciplines.first.name, 'Math');
    });

    test('insert and get tasks', () async {
      final task = TaskEntity(name: 'Do homework');
      await repository.insertTask(task);

      final tasks = await repository.getAllTasks().first;
      expect(tasks.length, 1);
      expect(tasks.first.name, 'Do homework');
    });

    test('delete a task', () async {
      final task = TaskEntity(id: 1, name: 'Task to be deleted');
      await repository.insertTask(task);
      var tasks = await repository.getAllTasks().first;
      expect(tasks.length, 1);

      await repository.deleteTask(tasks.first);
      tasks = await repository.getAllTasks().first;
      expect(tasks.isEmpty, isTrue);
    });
  });
}