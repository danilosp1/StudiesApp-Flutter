import 'package:flutter/material.dart';
import '../../data/models/discipline_entity.dart';
import '../../data/models/task_entity.dart';
import '../../data/repository/app_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final AppRepository _repository;

  List<TaskEntity> tasks = [];
  List<DisciplineEntity> disciplines = [];
  
  bool isLoading = true;
  String? errorMessage;
  
  TaskEntity? selectedTask;
  String? selectedTaskDisciplineName;


  TaskViewModel(this._repository) {
    _loadTasksAndDisciplines();
  }

  void _loadTasksAndDisciplines() {
    isLoading = true;
    notifyListeners();

    _repository.getAllTasks().listen((taskList) {
      tasks = taskList;
      if (!isLoading) notifyListeners();
    });

    _repository.getAllDisciplines().listen((disciplineList) {
      disciplines = disciplineList;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> loadTaskDetailsById(int taskId) async {
    isLoading = true;
    notifyListeners();
    
    try {
      _repository.getTaskById(taskId).listen((task) async {
        selectedTask = task;
        if (task?.disciplineId != null) {
          final discipline = await _repository.getDisciplineById(task!.disciplineId!).first;
          selectedTaskDisciplineName = discipline?.name;
        } else {
          selectedTaskDisciplineName = null;
        }
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> addTask(TaskEntity task) async {
    await _repository.insertTask(task);
  }

  Future<void> updateTaskCompletion(TaskEntity task, bool isCompleted) async {
    final updatedTask = task.copyWith(isCompleted: isCompleted);
    await _repository.updateTask(updatedTask);
  }

  Future<void> deleteTask(TaskEntity task) async {
    await _repository.deleteTask(task);
  }
}