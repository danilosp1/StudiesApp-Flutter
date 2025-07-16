import 'package:floor/floor.dart';
import '../models/task_entity.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM tasks WHERE id = :id')
  Stream<TaskEntity?> findTaskByIdAsStream(int id);

  @Query('SELECT * FROM tasks ORDER BY dueDate ASC, dueTime ASC')
  Stream<List<TaskEntity>> getAllTasksAsStream();

  @Query('SELECT * FROM tasks WHERE disciplineId = :disciplineId ORDER BY dueDate ASC, dueTime ASC')
  Stream<List<TaskEntity>> getTasksByDisciplineAsStream(int disciplineId);
  
  @Query('SELECT * FROM tasks WHERE isCompleted = 0 ORDER BY dueDate ASC, dueTime ASC')
  Stream<List<TaskEntity>> getPendingTasksAsStream();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertTask(TaskEntity task);

  @update
  Future<void> updateTask(TaskEntity task);

  @delete
  Future<void> deleteTask(TaskEntity task);
}