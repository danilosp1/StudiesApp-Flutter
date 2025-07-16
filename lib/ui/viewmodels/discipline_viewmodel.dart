import 'package:flutter/material.dart';
import '../../data/models/discipline_entity.dart';
import '../../data/models/material_link_entity.dart';
import '../../data/models/subject_schedule_entity.dart';
import '../../data/models/task_entity.dart';
import '../../data/remote/models/motd_response.dart';
import '../../data/repository/app_repository.dart';
import 'package:intl/intl.dart';

class SubjectUI {
  final String name;
  final String time;
  final String location;

  SubjectUI({required this.name, required this.time, required this.location});
}

class DisciplineViewModel extends ChangeNotifier {
  final AppRepository _repository;

  List<DisciplineEntity> disciplines = [];
  Map<int, List<SubjectScheduleEntity>> _schedules = {};

  MotdResponse? messageOfTheDay;

  bool isLoading = true;
  String? errorMessage;

  DisciplineEntity? selectedDiscipline;
  List<SubjectScheduleEntity> selectedSchedules = [];
  List<TaskEntity> selectedTasks = [];
  List<MaterialLinkEntity> selectedMaterialLinks = [];

  DisciplineViewModel(this._repository) {
    _loadAllDisciplinesAndSchedules();
    _loadMessageOfTheDay();
  }

  void _loadMessageOfTheDay() {
    _repository.getMessageOfTheDay().listen((motd) {
      messageOfTheDay = motd;
      notifyListeners();
    });
  }

  void _loadAllDisciplinesAndSchedules() {
    isLoading = true;
    notifyListeners();

    _repository.getAllDisciplines().listen((disciplineList) {
      disciplines = disciplineList;
      _loadSchedulesForDisciplines();
    });
  }

  void _loadSchedulesForDisciplines() {
    if (disciplines.isEmpty) {
      isLoading = false;
      notifyListeners();
      return;
    }

    int loadedCount = 0;
    _schedules.clear();
    for (var discipline in disciplines) {
      _repository.getSchedulesForDiscipline(discipline.id!).listen((scheduleList) {
        _schedules[discipline.id!] = scheduleList;
        loadedCount++;
        if (loadedCount == disciplines.length) {
          isLoading = false;
          notifyListeners();
        }
      });
    }
  }

  Future<void> addDiscipline(DisciplineEntity discipline, List<SubjectScheduleEntity> schedules) async {
    await _repository.insertDisciplineWithSchedules(discipline, schedules);
  }

  Future<void> loadDisciplineDetailsById(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      _repository.getDisciplineById(id).listen((discipline) {
        selectedDiscipline = discipline;
      });
      _repository.getSchedulesForDiscipline(id).listen((schedules) {
        selectedSchedules = schedules;
      });
      _repository.getTasksByDiscipline(id).listen((tasks) {
        selectedTasks = tasks;
      });
      _repository.getMaterialLinksByDiscipline(id).listen((links) {
        selectedMaterialLinks = links;
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  List<SubjectUI> getTodaySubjects() {
    final now = DateTime.now();
    final todayDayName = DateFormat('EEEE', 'pt_BR').format(now);

    final List<SubjectUI> todaySubjects = [];

    for (var discipline in disciplines) {
      final disciplineSchedules = _schedules[discipline.id] ?? [];
      for (var schedule in disciplineSchedules) {
        if (schedule.dayOfWeek.toLowerCase() == todayDayName.toLowerCase()) {
          todaySubjects.add(SubjectUI(
            name: discipline.name,
            time: '${schedule.startTime} - ${schedule.endTime}',
            location: discipline.location ?? 'Local não definido',
          ));
        }
      }
    }

    todaySubjects.sort((a, b) => a.time.compareTo(b.time));
    return todaySubjects;
  }

  Future<void> addMaterialLink(String url, String? description) async {
    if (selectedDiscipline?.id != null) {
      final newLink = MaterialLinkEntity(
        disciplineId: selectedDiscipline!.id!,
        url: url,
        description: description,
      );
      await _repository.insertMaterialLink(newLink);
    }
  }

  Future<void> deleteMaterialLink(MaterialLinkEntity link) async {
    await _repository.deleteMaterialLink(link);
  }

  Future<void> deleteSelectedDiscipline() async {
    if (selectedDiscipline != null) {
      await _repository.deleteDiscipline(selectedDiscipline!);
    }
  }
}