import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dao/discipline_dao.dart';
import 'dao/material_link_dao.dart';
import 'dao/task_dao.dart';
import 'models/discipline_entity.dart';
import 'models/material_link_entity.dart';
import 'models/subject_schedule_entity.dart';
import 'models/task_entity.dart';

part 'app_database.g.dart';

@Database(
  version: 2,
  entities: [
    DisciplineEntity,
    SubjectScheduleEntity,
    TaskEntity,
    MaterialLinkEntity,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  DisciplineDao get disciplineDao;
  TaskDao get taskDao;
  MaterialLinkDao get materialLinkDao;
}