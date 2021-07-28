import 'package:flutter/material.dart';
import 'dart:collection';
import 'enums.dart';
import 'plant.dart';
import '../utils/utility.dart';

class Tile {
  TileType _type = TileType.none;
  List<Plant> _plants = <Plant>[];

  Tile({required TileType type}) {
    _type = type;
  }

  Tile.fromJson(Map<String, dynamic> json)
      : _type = stringToTileType(json['type']),
        _plants = (json['plants'] as List).map((i) => Plant.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {'type': tileTypeToString(_type), 'plants': _plants};

  TileType get type => _type;
  UnmodifiableListView<Plant> get plants => UnmodifiableListView(_plants);

  set type(TileType value) => _type = value;

  void updatePlants({required List<String> plantsNames, required List<String> plantedDates, required List<PlantType> plantsTypes}) {
    int plantsLength = _plants.length;

    if (plantsLength != plantsNames.length || plantsLength != plantedDates.length || plantsLength != plantsTypes.length) {
      return;
    }

    for (int i = 0; i < plantsLength; i++) {
      _updatePlant(index: i, plantType: plantsTypes[i], plantName: plantsNames[i], plantedDate: plantedDates[i]);
    }
  }

  void _updatePlant({required int index, required PlantType plantType, required String plantName, required String plantedDate}) {
    _plants[index].type = plantType;
    _plants[index].name = plantName;
    _plants[index].plantedDate = plantedDate;
  }

  void addPlant({required PlantType plantType}) {
    _plants.add(Plant(type: plantType));
  }

  void removePlant({required int index}) {
    _plants.removeAt(index);
  }
}
