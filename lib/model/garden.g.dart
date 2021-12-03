// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GardenAdapter extends TypeAdapter<Garden> {
  @override
  final int typeId = 2;

  @override
  Garden read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Garden(
      name: fields[1] as String,
      rows: fields[2] as int,
      columns: fields[3] as int,
    )
      ..id = fields[0] as String
      ..tiles = (fields[4] as List).cast<Tile>();
  }

  @override
  void write(BinaryWriter writer, Garden obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.rows)
      ..writeByte(3)
      ..write(obj.columns)
      ..writeByte(4)
      ..write(obj.tiles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GardenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
