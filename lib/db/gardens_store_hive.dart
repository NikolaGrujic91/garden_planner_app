import 'package:garden_planner_app/utils/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:garden_planner_app/db/gardens_store.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/garden.dart';
import 'package:garden_planner_app/model/json_constants.dart';
import 'package:garden_planner_app/model/plant.dart';
import 'package:garden_planner_app/model/tile.dart';

/// Store responsible for handling the gardens data
class GardensStoreHive extends ChangeNotifier implements GardensStore {
  /// Creates a new instance
  GardensStoreHive() {
    _loadGardens();
  }

  /// Hive box
  late Box<List<dynamic>> box;

  /// List of Gardens
  List<Garden> gardens = [];

  /// Index of currently selected garden
  int selectedGardenIndex = 0;

  /// Index of currently selected tile
  int selectedTileIndex = 0;

  /// Convert object data to JSON
  Map<String, dynamic> toJson() => <String, dynamic>{kJsonGardens: gardens};

  @override
  void addGarden(Garden garden) {
    gardens.add(garden);
    notifyListeners();
  }

  @override
  void removeGarden(Garden? garden) {
    selectedGardenIndex = 0;

    if (garden != null) {
      gardens.remove(garden);
    }

    notifyListeners();
  }

  @override
  Garden getSelectedGarden() {
    return gardens[selectedGardenIndex];
  }

  @override
  void updateSelectedGarden({
    required String name,
    required int rows,
    required int columns,
  }) {
    gardens[selectedGardenIndex].name = name;
    gardens[selectedGardenIndex].rows = rows;
    gardens[selectedGardenIndex].columns = columns;
    gardens[selectedGardenIndex].updateTiles();
    notifyListeners();
  }

  @override
  Tile getSelectedTile() {
    return gardens[selectedGardenIndex].tiles[selectedTileIndex];
  }

  @override
  void updateSelectedTileType({required TileType type}) {
    gardens[selectedGardenIndex]
        .updateTileType(index: selectedTileIndex, type: type);
    notifyListeners();
  }

  @override
  void updateSelectedTilePlants({
    required List<String> plantsNames,
    required List<String> plantedDates,
    required List<PlantType> plantsTypes,
    required List<String> descriptions,
  }) {
    gardens[selectedGardenIndex].tiles[selectedTileIndex].updatePlants(
          plantsNames: plantsNames,
          plantedDates: plantedDates,
          plantsTypes: plantsTypes,
          descriptions: descriptions,
        );
    notifyListeners();
  }

  @override
  void addPlant({
    required int tileIndex,
    required PlantType plantType,
  }) {
    gardens[selectedGardenIndex]
        .tiles[tileIndex]
        .addPlant(plantType: plantType);
  }

  @override
  void removePlant({required int index}) {
    gardens[selectedGardenIndex]
        .tiles[selectedTileIndex]
        .removePlant(index: index);
  }

  @override
  Future<void> saveGardens() async {
    try {
      await _trySaveGardens();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _trySaveGardens() async {
    await box.put(kHiveGardensKey, gardens);
  }

  Future<void> _loadGardens() async {
    try {
      await _tryLoadGardens();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _tryLoadGardens() async {
    await Hive.initFlutter();

    // Register adapters
    Hive
      ..registerAdapter(TileTypeAdapter())
      ..registerAdapter(PlantTypeAdapter())
      ..registerAdapter(GardenAdapter())
      ..registerAdapter(TileAdapter())
      ..registerAdapter(PlantAdapter());

    box = await Hive.openBox<List<dynamic>>(kHiveGardensBox);
    final unboxedGardens = box.get(kHiveGardensKey);

    if (unboxedGardens != null && unboxedGardens.isNotEmpty) {
      gardens = unboxedGardens.cast<Garden>();
    }
  }
}
