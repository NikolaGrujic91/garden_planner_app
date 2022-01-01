import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/utils/color_constants.dart';
import 'package:garden_planner_app/utils/string_constants.dart';
import 'package:garden_planner_app/utils/svg_icon_constants.dart';

/// Convert TileType enum to String
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

/// Convert String to TileType enum
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

/// Convert TileType enum to Color
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

/// Convert PlantType enum to String
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

/// Convert String to PlantType enum
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

/// Convert PlantType enum to SvgPicture
SvgPicture plantTypeToSvgPicture(PlantType type) {
  switch (type) {
    case PlantType.tree:
      return kTreeIcon30;
    case PlantType.fruit:
      return kFruitIcon30;
    case PlantType.vegetable:
      return kVegetableIcon30;
    case PlantType.flower:
      return kFlowerIcon30;
  }
}

/// Convert PlantType enum to SvgPicture
SvgPicture plantTypeToSvgPicture60(PlantType type) {
  switch (type) {
    case PlantType.tree:
      return kTreeIcon60;
    case PlantType.fruit:
      return kFruitIcon60;
    case PlantType.vegetable:
      return kVegetableIcon60;
    case PlantType.flower:
      return kFlowerIcon60;
  }
}
