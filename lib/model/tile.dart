import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/json_constants.dart';
import 'package:garden_planner_app/model/plant.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:uuid/uuid.dart';

/// Model class that stores Tile data
class Tile {
  /// Creates a new instance
  Tile({required this.type});

  /// Creates a new instance from JSON
  Tile.fromJson(Map<String, dynamic> json)
      : id = json[kJsonId].toString(),
        type = stringToTileType(json[kJsonType].toString()),
        plants =
            (json[kJsonPlants] as List).map((i) => Plant.fromJson(i)).toList();

  /// ID
  String id = const Uuid().v1();

  /// Tile type
  TileType type = TileType.none;

  /// Plants in tile
  List<Plant> plants = <Plant>[];

  /// Convert object data to JSON
  Map<String, dynamic> toJson() => {
        kJsonId: id,
        kJsonType: tileTypeToString(type),
        kJsonPlants: plants,
      };

  /// Update tile plants based on given input
  void updatePlants({
    required List<String> plantsNames,
    required List<String> plantedDates,
    required List<PlantType> plantsTypes,
    required List<String> descriptions,
  }) {
    final plantsLength = plants.length;

    if (plantsLength != plantsNames.length ||
        plantsLength != plantedDates.length ||
        plantsLength != plantsTypes.length ||
        plantsLength != descriptions.length) {
      return;
    }

    for (var i = 0; i < plantsLength; i++) {
      plants[i].type = plantsTypes[i];
      plants[i].name = plantsNames[i];
      plants[i].plantedDate = plantedDates[i];
      plants[i].description = descriptions[i];
    }
  }

  /// Add plant to tile
  void addPlant({required PlantType plantType}) {
    plants.add(Plant(type: plantType));
  }

  /// Remove plant from tile at index
  void removePlant({required int index}) {
    plants.removeAt(index);
  }
}
