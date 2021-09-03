import 'package:garden_planner_app/utils/hive_field_id.dart';
import 'package:garden_planner_app/utils/hive_type_id.dart';
import 'package:hive/hive.dart';

part 'enums.g.dart';

/// Enumeration of tiles types
@HiveType(typeId: kHiveTypeId3)
enum TileType {
  /// Tile is empty
  @HiveField(kHiveFieldId0)
  none,

  /// Tile represents plant
  @HiveField(kHiveFieldId1)
  plant,

  /// Tile represents home
  @HiveField(kHiveFieldId2)
  home,

  /// Tile represents path
  @HiveField(kHiveFieldId3)
  path
}

/// Enumeration of plant types
@HiveType(typeId: kHiveTypeId4)
enum PlantType {
  /// Plant represents tree
  @HiveField(kHiveFieldId0)
  tree,

  /// Plant represents fruit
  @HiveField(kHiveFieldId1)
  fruit,

  /// Plant represents vegetable
  @HiveField(kHiveFieldId2)
  vegetable,

  /// Plant represents flower
  @HiveField(kHiveFieldId3)
  flower
}
