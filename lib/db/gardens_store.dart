import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/garden.dart';
import 'package:garden_planner_app/model/tile.dart';

/// Store interface declaration
abstract class GardensStore {
  /// Add garden
  void addGarden(Garden garden);

  /// Remove garden
  void removeGarden(Garden? garden);

  /// Get selected garden
  Garden getSelectedGarden();

  /// Update selected garden
  void updateSelectedGarden({
    required String name,
    required int rows,
    required int columns,
  });

  /// Get selected tile
  Tile getSelectedTile();

  /// Update selected tile type
  void updateSelectedTileType({required TileType type});

  /// Update selected tile plants
  void updateSelectedTilePlants({
    required List<String> plantsNames,
    required List<String> plantedDates,
    required List<PlantType> plantsTypes,
    required List<String> descriptions,
  });

  /// Add plant to tile
  void addPlant({
    required int tileIndex,
    required PlantType plantType,
  });

  /// Remove plant from tile
  void removePlant({required int index});

  /// Save gardens
  Future<void> saveGardens();
}
