import 'package:flutter/material.dart';
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
      return Colors.black;
    case TileType.plant:
      return Color.fromARGB(255, 146, 163, 116);
    case TileType.home:
      return Color.fromARGB(255, 134, 134, 134);
    case TileType.path:
      return Color.fromARGB(255, 139, 122, 95);
  }
}
