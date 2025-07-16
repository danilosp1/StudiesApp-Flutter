import 'package:floor/floor.dart';
import 'discipline_entity.dart';

@Entity(
  tableName: 'tasks',
  foreignKeys: [
    ForeignKey(
      childColumns: ['disciplineId'],
      parentColumns: ['id'],
      entity: DisciplineEntity,
      onDelete: ForeignKeyAction.setNull,
    )
  ],
  indices: [Index(value: ['disciplineId'])],
)
class TaskEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int? disciplineId;
  final String name;
  final String? description;
  final String? dueDate;
  final String? dueTime;
  final bool isCompleted;

  TaskEntity({
    this.id,
    this.disciplineId,
    required this.name,
    this.description,
    this.dueDate,
    this.dueTime,
    this.isCompleted = false,
  });

  TaskEntity copyWith({bool? isCompleted}) {
    return TaskEntity(
      id: id,
      disciplineId: disciplineId,
      name: name,
      description: description,
      dueDate: dueDate,
      dueTime: dueTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}