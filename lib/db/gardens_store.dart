import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/garden.dart';
import 'package:garden_planner_app/model/plant.dart';
import 'package:garden_planner_app/model/tile.dart';

/// Store interface declaration
abstract class GardensStore {
  /// Add garden
  void addGarden(Garden garden);

  /// Remove garden
  void removeSelectedGarden();

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
  void updateSelectedPlant({
    required String plantName,
    required String plantedDate,
    required String wateringStartDate,
    required PlantType plantType,
    required String description,
  });

  /// Get selected plant
  Plant getSelectedPlant();

  /// Add plant to tile
  void addPlant({
    required int tileIndex,
    required PlantType plantType,
  });

  /// Remove selected plant from tile
  void removeSelectedPlant();

  /// Get selected image
  String getSelectedImage();

  /// Add image to plant
  void addImages(List<String> images);

  /// Remove selected image from plant
  void removeSelectedImage();

  /// Save gardens
  Future<void> saveGardens();
}
