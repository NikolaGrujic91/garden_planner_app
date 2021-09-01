import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/json_constants.dart';
import 'package:garden_planner_app/model/tile.dart';
import 'package:uuid/uuid.dart';

/// Model class that stores Garden data
class Garden {
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
        tiles =
            (json[kJsonTiles] as List).map((i) => Tile.fromJson(i)).toList();

  /// ID
  String id = const Uuid().v1();

  /// Garden name
  String name = '';

  /// Number of tiles grid rows
  int rows = 0;

  /// Number of tiles grid columns
  int columns = 0;

  /// Tiles
  List<Tile> tiles = <Tile>[];

  /// Convert object data to JSON
  Map<String, dynamic> toJson() => {
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
