import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:garden_planner_app/db/gardens_store.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/garden.dart';
import 'package:garden_planner_app/model/json_constants.dart';
import 'package:garden_planner_app/model/tile.dart';
import 'package:path_provider/path_provider.dart';

/// Store responsible for handling the gardens data
class GardensStoreJson extends ChangeNotifier implements GardensStore {
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
    gardens = (json[kJsonGardens] as List)
        .map((dynamic i) => Garden.fromJson(i as Map<String, dynamic>))
        .toList();
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
