import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/garden.dart';
import 'package:garden_planner_app/model/json_constants.dart';
import 'package:garden_planner_app/model/tile.dart';
import 'package:path_provider/path_provider.dart';

/// Store responsible for handling the gardens data
class GardensStoreJson extends ChangeNotifier {
  /// Creates a new instance
  GardensStoreJson() {
    _loadGardens();
  }

  /// List of Gardens
  List<Garden> gardens = [];

  /// Index of currently selected garden
  int selectedGardenIndex = 0;

  /// Index of currently selected tile
  int selectedTileIndex = 0;

  /// Convert object data to JSON
  Map<String, dynamic> toJson() => {kJsonGardens: gardens};

  /// Add garden
  void addGarden(Garden garden) {
    gardens.add(garden);
    notifyListeners();
  }

  /// Remove garden
  void removeGarden(Garden? garden) {
    selectedGardenIndex = 0;

    if (garden != null) {
      gardens.remove(garden);
    }

    notifyListeners();
  }

  /// Get selected garden
  Garden getSelectedGarden() {
    return gardens[selectedGardenIndex];
  }

  /// Update selected garden
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

  /// Get selected tile
  Tile getSelectedTile() {
    return gardens[selectedGardenIndex].tiles[selectedTileIndex];
  }

  /// Update selected tile type
  void updateSelectedTileType({required TileType type}) {
    gardens[selectedGardenIndex]
        .updateTileType(index: selectedTileIndex, type: type);
    notifyListeners();
  }

  /// Update selected tile plants
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

  /// Add plant to tile
  void addPlant({required int tileIndex, required PlantType plantType}) {
    gardens[selectedGardenIndex]
        .tiles[tileIndex]
        .addPlant(plantType: plantType);
  }

  /// Remove plant from tile
  void removePlant({required int index}) {
    gardens[selectedGardenIndex]
        .tiles[selectedTileIndex]
        .removePlant(index: index);
  }

  /// Save gardens to JSON file
  Future<void> saveGardens() async {
    try {
      final file = await _trySaveGardens();
      debugPrint(file.path);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<File> _trySaveGardens() async {
    final file = await _localFile();
    return file.writeAsString(jsonEncode(toJson()));
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
    final file = await _localFile();
    final fileContent = await file.readAsString();
    final json = await jsonDecode(fileContent) as Map<String, dynamic>;
    gardens =
        (json[kJsonGardens] as List).map((i) => Garden.fromJson(i)).toList();
  }

  Future<File> _localFile() async {
    final path = await _localPath();
    final file = File('$path/$kJsonFileName').create(recursive: true);
    return file;
  }

  Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
