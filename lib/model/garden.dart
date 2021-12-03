import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/tile.dart';
import 'package:garden_planner_app/utils/hive_field_id.dart';
import 'package:garden_planner_app/utils/hive_type_id.dart';
import 'package:garden_planner_app/utils/json_constants.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'garden.g.dart';

/// Model class that stores Garden data
@HiveType(typeId: kHiveTypeId2)
class Garden extends HiveObject {
  /// Creates a new instance
  Garden({required this.name, required this.rows, required this.columns}) {
    _createTiles();
  }

  /// Creates a new instance from JSON
  Garden.fromJson(Map<String, dynamic> json)
      : id = json[kJsonId].toString(),
        name = json[kJsonName].toString(),
        rows = json[kJsonRows] as int,
        columns = json[kJsonColumns] as int,
        tiles = (json[kJsonTiles] as List)
            .map((dynamic i) => Tile.fromJson(i as Map<String, dynamic>))
            .toList();

  /// ID
  @HiveField(kHiveFieldId0)
  String id = const Uuid().v1();

  /// Garden name
  @HiveField(kHiveFieldId1)
  String name = '';

  /// Number of tiles grid rows
  @HiveField(kHiveFieldId2)
  int rows = 0;

  /// Number of tiles grid columns
  @HiveField(kHiveFieldId3)
  int columns = 0;

  /// Tiles
  @HiveField(kHiveFieldId4)
  List<Tile> tiles = <Tile>[];

  /// Convert object data to JSON
  Map<String, dynamic> toJson() => <String, dynamic>{
        kJsonId: id,
        kJsonName: name,
        kJsonRows: rows,
        kJsonColumns: columns,
        kJsonTiles: tiles
      };

  /// Update tiles list after number of columns or rows has changed
  void updateTiles() {
    final newSize = columns * rows;

    // Grid expanding
    if (tiles.length < newSize) {
      for (var index = 0; index <= newSize; index++) {
        if (tiles.length > index) {
          continue;
        }

        tiles.add(Tile(type: TileType.plant));
      }
    }

    // Grid shrinking
    else {
      while (tiles.length > newSize) {
        tiles.removeLast();
      }
    }
  }

  /// Update tile type
  void updateTileType({required int index, required TileType type}) {
    tiles[index].type = type;
  }

  /// Add plant to tile
  void addTilePlant({required int tileIndex, required PlantType plantType}) {
    tiles[tileIndex].addPlant(plantType: plantType);
  }

  void _createTiles() {
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        tiles.add(Tile(type: TileType.plant));
      }
    }
  }
}
