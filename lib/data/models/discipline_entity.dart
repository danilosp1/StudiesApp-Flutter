import 'package:floor/floor.dart';

@Entity(tableName: 'disciplines')
class DisciplineEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String? location;
  final String? professor;
  final String? imageUri;

  DisciplineEntity({
    this.id,
    required this.name,
    this.location,
    this.professor,
    this.imageUri,
  });
}