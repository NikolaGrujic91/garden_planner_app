import 'package:flutter/material.dart';
import 'constants.dart';
import '../model/enums.dart';

String tileTypeToString(TileType type) {
  switch (type) {
    case TileType.none:
      return kNone;
    case TileType.plant:
      return kPlant;
    case TileType.home:
      return kHome;
    case TileType.path:
      return kPath;
  }
}

TileType stringToTileType(String value) {
  switch (value) {
    case kNone:
      return TileType.none;
    case kPlant:
      return TileType.plant;
    case kHome:
      return TileType.home;
    case kPath:
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

String plantTypeToString(PlantType type) {
  switch (type) {
    case PlantType.tree:
      return kTree;
    case PlantType.fruit:
      return kFruit;
    case PlantType.vegetable:
      return kVegetable;
    case PlantType.flower:
      return kFlower;
  }
}

PlantType stringToPlantType(String value) {
  switch (value) {
    case kTree:
      return PlantType.tree;
    case kFruit:
      return PlantType.fruit;
    case kVegetable:
      return PlantType.vegetable;
    case kFlower:
      return PlantType.flower;
    default:
      return PlantType.tree;
  }
}

IconData plantTypeToIconData(PlantType type) {
  switch (type) {
    case PlantType.tree:
      return kTreeIcon;
    case PlantType.fruit:
      return kFruitIcon;
    case PlantType.vegetable:
      return kVegetableIcon;
    case PlantType.flower:
      return kFlowerIcon;
  }
}
