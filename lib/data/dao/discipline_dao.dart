import 'package:floor/floor.dart';
import '../models/discipline_entity.dart';
import '../models/subject_schedule_entity.dart';

@dao
abstract class DisciplineDao {
  @Query('SELECT * FROM disciplines ORDER BY name ASC')
  Stream<List<DisciplineEntity>> getAllDisciplinesAsStream();

  @Query('SELECT * FROM disciplines WHERE id = :id')
  Stream<DisciplineEntity?> findDisciplineByIdAsStream(int id);

  @Query('SELECT * FROM subject_schedules WHERE disciplineId = :disciplineId')
  Stream<List<SubjectScheduleEntity>> findSchedulesForDisciplineAsStream(int disciplineId);

  @insert
  Future<int> insertDiscipline(DisciplineEntity discipline);

  @insert
  Future<void> insertSchedules(List<SubjectScheduleEntity> schedules);

  @update
  Future<void> updateDiscipline(DisciplineEntity discipline);

  @delete
  Future<void> deleteDiscipline(DisciplineEntity discipline);
}