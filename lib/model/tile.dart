import 'package:flutter/material.dart';
import 'enums.dart';
import '../utils/utility.dart';

class Tile {
  TileType _type = TileType.none;
  String _plantName = '';
  String _plantedDate = '';

  IconData _icon = Icons.api;
  Color _tileColor = Colors.black;

  Tile({required TileType type, required String plantName, required String plantedDate}) {
    _type = type;
    _plantName = plantName;
    _plantedDate = plantedDate;

    _icon = tileTypeToIconData(_type);
    _tileColor = tileTypeToTileColor(_type);
  }

  Tile.fromJson(Map<String, dynamic> json)
      : _type = stringToTileType(json['type']),
        _plantName = json['plantName'],
        _plantedDate = json['plantedDate'] {
    _icon = tileTypeToIconData(_type);
    _tileColor = tileTypeToTileColor(_type);
  }

  Map<String, dynamic> toJson() => {'type': tileTypeToString(_type), 'plantName': _plantName, 'plantedDate': _plantedDate};

  TileType get type => _type;
  String get plantName => _plantName;
  String get plantedDate => _plantedDate;
  IconData get icon => _icon;
  Color get tileColor => _tileColor;

  set type(TileType value) {
    _type = value;
    _icon = tileTypeToIconData(_type);
    _tileColor = tileTypeToTileColor(_type);
  }

  set plantName(String value) => _plantName = value;
  set plantedDate(String value) => _plantedDate = value;
}
