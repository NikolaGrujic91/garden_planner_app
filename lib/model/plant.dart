import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/json_constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:uuid/uuid.dart';

/// Model class that stores Plant data
class Plant {
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
  String id = const Uuid().v1();

  /// Plant type
  PlantType type = PlantType.tree;

  /// Name
  String name = '';

  /// Planted date
  String plantedDate = '';

  /// Additional description
  String description = '';

  /// Convert object data to JSON
  Map<String, String> toJson() => {
        kJsonId: id,
        kJsonType: plantTypeToString(type),
        kJsonPlantName: name,
        kJsonPlantedDate: plantedDate,
        kJsonDescription: description,
      };
}
