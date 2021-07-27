import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'enums.dart';
import 'garden.dart';

class GardensStore extends ChangeNotifier {
  List<Garden> _gardens = [];
  int _selectedGardenIndex = 0;
  int _selectedTileIndex = 0;

  GardensStore() {
    _loadGardens();
  }

  Map<String, dynamic> toJson() => {'gardens': _gardens};

  UnmodifiableListView<Garden> get gardens => UnmodifiableListView(_gardens);
  int get selectedGardenIndex => _selectedGardenIndex;
  int get selectedTileIndex => _selectedTileIndex;

  void setSelectedGardenIndex(int index) {
    _selectedGardenIndex = index;
  }

  void setSelectedTileIndex(int index) {
    _selectedTileIndex = index;
  }

  void addGarden(Garden garden) {
    _gardens.add(garden);
    notifyListeners();
  }

  void removeGarden(Garden? garden) {
    setSelectedGardenIndex(0);

    if (garden != null) {
      _gardens.remove(garden);
    }

    notifyListeners();
  }

  void updateSelectedGarden({required String name, required int rows, required int columns}) {
    _gardens[_selectedGardenIndex].name = name;
    _gardens[_selectedGardenIndex].rows = rows;
    _gardens[_selectedGardenIndex].columns = columns;
    _gardens[_selectedGardenIndex].updateTiles();
    notifyListeners();
  }

  void updateSelectedTileType({required TileType type}) {
    _gardens[_selectedGardenIndex].updateTileType(index: _selectedTileIndex, type: type);
    notifyListeners();
  }

  void updateSelectedTilePlants({required List<String> plantsNames, required List<String> plantedDates, required List<PlantType> plantsTypes}) {
    _gardens[_selectedGardenIndex].tiles[_selectedTileIndex].updatePlants(plantsNames: plantsNames, plantedDates: plantedDates, plantsTypes: plantsTypes);
    notifyListeners();
  }

  void addPlant({required int tileIndex, required PlantType plantType}) {
    _gardens[_selectedGardenIndex].tiles[tileIndex].addPlant(plantType: plantType);
  }

  Future<void> saveGardens() async {
    try {
      File file = await _trySaveGardens();
      print(file.path);
    } catch (e) {
      print(e);
    }
  }

  Future<File> _trySaveGardens() async {
    File file = await _localFile();
    return await file.writeAsString(jsonEncode(toJson()));
  }

  Future<void> _loadGardens() async {
    try {
      await _tryLoadGardens();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _tryLoadGardens() async {
    File file = await _localFile();
    String fileContent = await file.readAsString();
    Map<String, dynamic> json = await jsonDecode(fileContent);
    _gardens = (json['gardens'] as List).map((i) => Garden.fromJson(i)).toList();
  }

  Future<File> _localFile() async {
    final path = await _localPath();
    var file = File('$path/gardens.json').create(recursive: true);
    return file;
  }

  Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
