import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/plant.dart';
import 'package:garden_planner_app/utils/hive_field_id.dart';
import 'package:garden_planner_app/utils/hive_type_id.dart';
import 'package:garden_planner_app/utils/json_constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'tile.g.dart';

/// Model class that stores Tile data
@HiveType(typeId: kHiveTypeId1)
class Tile extends HiveObject {
  /// Creates a new instance
  Tile({required this.type});

  /// Creates a new instance from JSON
  Tile.fromJson(Map<String, dynamic> json)
      : id = json[kJsonId].toString(),
        type = stringToTileType(json[kJsonType].toString()),
        plants = (json[kJsonPlants] as List)
            .map((dynamic i) => Plant.fromJson(i as Map<String, dynamic>))
            .toList();

  /// ID
  @HiveField(kHiveFieldId0)
  String id = const Uuid().v1();

  /// Tile type
  @HiveField(kHiveFieldId1)
  TileType type = TileType.none;

  /// Plants in tile
  @HiveField(kHiveFieldId2)
  List<Plant> plants = <Plant>[];

  /// Convert object data to JSON
  Map<String, dynamic> toJson() => <String, dynamic>{
        kJsonId: id,
        kJsonType: tileTypeToString(type),
        kJsonPlants: plants,
      };

  /// Update tile plants based on given input
  void updatePlant({
    required int index,
    required String plantsName,
    required String plantedDate,
    required String wateringStartDate,
    required String fertilizingStartDate,
    required PlantType plantsType,
    required String description,
  }) {
    if (index >= plants.length) {
      return;
    }

    plants[index].type = plantsType;
    plants[index].name = plantsName;
    plants[index].plantedDate = plantedDate;
    plants[index].wateringStartDate = wateringStartDate;
    plants[index].fertilizingStartDate = fertilizingStartDate;
    plants[index].description = description;
  }

  /// Add plant to tile
  void addPlant({required PlantType plantType}) {
    plants.add(Plant(type: plantType));
  }

  /// Remove plant from tile at index
  void removePlant({required int index}) {
    if (index >= plants.length) {
      return;
    }

    plants.removeAt(index);
  }
}
