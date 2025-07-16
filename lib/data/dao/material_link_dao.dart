import 'package:floor/floor.dart';
import '../models/material_link_entity.dart';

@dao
abstract class MaterialLinkDao {
  @Query('SELECT * FROM material_links WHERE disciplineId = :disciplineId ORDER BY id ASC')
  Stream<List<MaterialLinkEntity>> getMaterialLinksByDisciplineAsStream(int disciplineId);

  @Query('SELECT * FROM material_links WHERE id = :linkId')
  Stream<MaterialLinkEntity?> getMaterialLinkByIdAsStream(int linkId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMaterialLink(MaterialLinkEntity materialLink);

  @update
  Future<void> updateMaterialLink(MaterialLinkEntity materialLink);

  @delete
  Future<void> deleteMaterialLink(MaterialLinkEntity materialLink);
}