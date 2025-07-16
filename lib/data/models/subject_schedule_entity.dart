import 'package:floor/floor.dart';
import 'discipline_entity.dart';

@Entity(
  tableName: 'subject_schedules',
  foreignKeys: [
    ForeignKey(
      childColumns: ['disciplineId'],
      parentColumns: ['id'],
      entity: DisciplineEntity,
      onDelete: ForeignKeyAction.cascade,
    )
  ],
  indices: [Index(value: ['disciplineId'])],
)
class SubjectScheduleEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int disciplineId;
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  SubjectScheduleEntity({
    this.id,
    required this.disciplineId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });
}