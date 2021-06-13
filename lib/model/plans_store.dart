import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'enums.dart';
import 'plan.dart';

class PlansStore extends ChangeNotifier {
  List<Plan> _plans = [];
  int _selectedPlanIndex = 0;
  int _selectedTileIndex = 0;

  PlansStore() {
    _loadPlans();
  }

  Map<String, dynamic> toJson() => {'plans': _plans};

  UnmodifiableListView<Plan> get plans => UnmodifiableListView(_plans);
  int get selectedPlanIndex => _selectedPlanIndex;
  int get selectedTileIndex => _selectedTileIndex;

  void setSelectedPlanIndex(int index) {
    _selectedPlanIndex = index;
  }

  void setSelectedTileIndex(int index) {
    _selectedTileIndex = index;
  }

  void addPlan(Plan plan) {
    _plans.add(plan);
    notifyListeners();
  }

  void removePlan(Plan? plan) {
    setSelectedPlanIndex(0);

    if (plan != null) {
      _plans.remove(plan);
    }

    notifyListeners();
  }

  void updatePlan({required String name, required int rows, required int columns}) {
    _plans[_selectedPlanIndex].name = name;
    _plans[_selectedPlanIndex].rows = rows;
    _plans[_selectedPlanIndex].columns = columns;
    _plans[_selectedPlanIndex].updateTiles();
    notifyListeners();
  }

  void updateTile({required TileType type, required String plantName, required String plantedDate}) {
    _plans[_selectedPlanIndex].updateTile(index: selectedTileIndex, type: type, plantName: plantName, plantedDate: plantedDate);
    notifyListeners();
  }

  Future<void> savePlans() async {
    try {
      File file = await _trySavePlans();
      print(file.path);
    } catch (e) {
      print(e);
    }
  }

  Future<File> _trySavePlans() async {
    File file = await _localFile();
    return await file.writeAsString(jsonEncode(toJson()));
  }

  Future<void> _loadPlans() async {
    try {
      await _tryLoadPlans();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _tryLoadPlans() async {
    File file = await _localFile();
    String fileContent = await file.readAsString();
    Map<String, dynamic> json = await jsonDecode(fileContent);
    _plans = (json['plans'] as List).map((i) => Plan.fromJson(i)).toList();
  }

  Future<File> _localFile() async {
    final path = await _localPath();
    var file = File('$path/plans.json').create(recursive: true);
    return file;
  }

  Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
