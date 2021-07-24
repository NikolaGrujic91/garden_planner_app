import 'package:flutter/material.dart';
import 'constants.dart';
import '../model/enums.dart';

String tileTypeToString(TileType type) {
  switch (type) {
    case TileType.none:
      return 'None';
    case TileType.plant:
      return 'Plant';
    case TileType.home:
      return 'Home';
    case TileType.path:
      return 'Path';
  }
}

TileType stringToTileType(String value) {
  switch (value) {
    case 'None':
      return TileType.none;
    case 'Plant':
      return TileType.plant;
    case 'Home':
      return TileType.home;
    case 'Path':
      return TileType.path;
    default:
      return TileType.none;
  }
}

IconData tileTypeToIconData(TileType type) {
  switch (type) {
    case TileType.none:
      return Icons.cancel;
    case TileType.plant:
      return Icons.api;
    case TileType.home:
      return Icons.home;
    case TileType.path:
      return Icons.directions_walk;
  }
}

Color tileTypeToTileColor(TileType type) {
  switch (type) {
    case TileType.none:
      return kTileNoneColor;
    case TileType.plant:
      return kTilePlantColor;
    case TileType.home:
      return kTileHomeColor;
    case TileType.path:
      return kTilePathColor;
  }
}
