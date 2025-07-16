import '../dao/discipline_dao.dart';
import '../dao/material_link_dao.dart';
import '../dao/task_dao.dart';
import '../models/discipline_entity.dart';
import '../models/material_link_entity.dart';
import '../models/subject_schedule_entity.dart';
import '../models/task_entity.dart';
import '../remote/api_service.dart';
import '../remote/models/motd_response.dart';

class AppRepository {
  final DisciplineDao _disciplineDao;
  final TaskDao _taskDao;
  final MaterialLinkDao _materialLinkDao;
  final ApiService _apiService;

  AppRepository(
    this._disciplineDao,
    this._taskDao,
    this._materialLinkDao,
    this._apiService,
  );

  Stream<List<DisciplineEntity>> getAllDisciplines() =>
      _disciplineDao.getAllDisciplinesAsStream();

  Stream<DisciplineEntity?> getDisciplineById(int id) =>
      _disciplineDao.findDisciplineByIdAsStream(id);

  Stream<List<SubjectScheduleEntity>> getSchedulesForDiscipline(int disciplineId) =>
      _disciplineDao.findSchedulesForDisciplineAsStream(disciplineId);

  Future<void> insertDisciplineWithSchedules(
      DisciplineEntity discipline, List<SubjectScheduleEntity> schedules) async {
    final disciplineId = await _disciplineDao.insertDiscipline(discipline);
    final schedulesWithDisciplineId = schedules
        .map((s) => SubjectScheduleEntity(
              disciplineId: disciplineId,
              dayOfWeek: s.dayOfWeek,
              startTime: s.startTime,
              endTime: s.endTime,
            ))
        .toList();
    await _disciplineDao.insertSchedules(schedulesWithDisciplineId);
  }

  Future<void> deleteDiscipline(DisciplineEntity discipline) =>
      _disciplineDao.deleteDiscipline(discipline);

  Stream<List<TaskEntity>> getAllTasks() => _taskDao.getAllTasksAsStream();

  Stream<TaskEntity?> getTaskById(int id) => _taskDao.findTaskByIdAsStream(id);

  Stream<List<TaskEntity>> getTasksByDiscipline(int disciplineId) =>
      _taskDao.getTasksByDisciplineAsStream(disciplineId);

  Future<void> insertTask(TaskEntity task) => _taskDao.insertTask(task);

  Future<void> updateTask(TaskEntity task) => _taskDao.updateTask(task);

  Future<void> deleteTask(TaskEntity task) => _taskDao.deleteTask(task);

  Stream<List<MaterialLinkEntity>> getMaterialLinksByDiscipline(int disciplineId) =>
      _materialLinkDao.getMaterialLinksByDisciplineAsStream(disciplineId);

  Future<void> insertMaterialLink(MaterialLinkEntity materialLink) =>
      _materialLinkDao.insertMaterialLink(materialLink);

  Future<void> updateMaterialLink(MaterialLinkEntity materialLink) =>
      _materialLinkDao.updateMaterialLink(materialLink);

  Future<void> deleteMaterialLink(MaterialLinkEntity materialLink) =>
      _materialLinkDao.deleteMaterialLink(materialLink);

  Stream<MotdResponse> getMessageOfTheDay() {
    return Stream.fromFuture(_apiService.getMessageOfTheDay());
  }
}