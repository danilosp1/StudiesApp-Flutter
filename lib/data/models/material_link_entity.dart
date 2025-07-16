import 'package:floor/floor.dart';
import 'discipline_entity.dart';

@Entity(
  tableName: 'material_links',
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
class MaterialLinkEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int disciplineId;
  final String url;
  final String? description;

  MaterialLinkEntity({
    this.id,
    required this.disciplineId,
    required this.url,
    this.description,
  });
}