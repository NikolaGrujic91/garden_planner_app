// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TileTypeAdapter extends TypeAdapter<TileType> {
  @override
  final int typeId = 3;

  @override
  TileType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TileType.none;
      case 1:
        return TileType.plant;
      case 2:
        return TileType.home;
      case 3:
        return TileType.path;
      default:
        return TileType.none;
    }
  }

  @override
  void write(BinaryWriter writer, TileType obj) {
    switch (obj) {
      case TileType.none:
        writer.writeByte(0);
        break;
      case TileType.plant:
        writer.writeByte(1);
        break;
      case TileType.home:
        writer.writeByte(2);
        break;
      case TileType.path:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TileTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlantTypeAdapter extends TypeAdapter<PlantType> {
  @override
  final int typeId = 4;

  @override
  PlantType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PlantType.tree;
      case 1:
        return PlantType.fruit;
      case 2:
        return PlantType.vegetable;
      case 3:
        return PlantType.flower;
      default:
        return PlantType.tree;
    }
  }

  @override
  void write(BinaryWriter writer, PlantType obj) {
    switch (obj) {
      case PlantType.tree:
        writer.writeByte(0);
        break;
      case PlantType.fruit:
        writer.writeByte(1);
        break;
      case PlantType.vegetable:
        writer.writeByte(2);
        break;
      case PlantType.flower:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
