import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/json_constants.dart';
import 'package:garden_planner_app/utils/hive_field_id.dart';
import 'package:garden_planner_app/utils/hive_type_id.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'plant.g.dart';

/// Model class that stores Plant data
@HiveType(typeId: kHiveTypeId0)
class Plant extends HiveObject {
  /// Creates a new instance
  Plant({required this.type});

  /// Creates a new instance from JSON
  Plant.fromJson(Map<String, dynamic> json)
      : id = json[kJsonId].toString(),
        type = stringToPlantType(json[kJsonType].toString()),
        name = json[kJsonPlantName].toString(),
        plantedDate = json[kJsonPlantedDate].toString(),
        description = json[kJsonDescription].toString();

  /// ID
  @HiveField(kHiveFieldId0)
  String id = const Uuid().v1();

  /// Plant type
  @HiveField(kHiveFieldId1)
  PlantType type = PlantType.tree;

  /// Name
  @HiveField(kHiveFieldId2)
  String name = '';

  /// Planted date
  @HiveField(kHiveFieldId3)
  String plantedDate = '';

  /// Additional description
  @HiveField(kHiveFieldId4)
  String description = '';

  /// Convert object data to JSON
  Map<String, dynamic> toJson() => <String, dynamic>{
        kJsonId: id,
        kJsonType: plantTypeToString(type),
        kJsonPlantName: name,
        kJsonPlantedDate: plantedDate,
        kJsonDescription: description,
      };
}
