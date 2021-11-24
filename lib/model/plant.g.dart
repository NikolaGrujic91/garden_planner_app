// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantAdapter extends TypeAdapter<Plant> {
  @override
  final int typeId = 0;

  @override
  Plant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plant(
      type: fields[1] as PlantType,
    )
      ..id = fields[0] as String
      ..name = fields[2] as String
      ..plantedDate = fields[3] as String
      ..description = fields[4] as String
      ..images = (fields[5] as List?)?.cast<String>()
      ..wateringStartDate = fields[6] as String
      ..wateringFrequency = fields[7] as int
      ..fertilizingStartDate = fields[8] as String
      ..fertilizingFrequency = fields[9] as int;
  }

  @override
  void write(BinaryWriter writer, Plant obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.plantedDate)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.wateringStartDate)
      ..writeByte(7)
      ..write(obj.wateringFrequency)
      ..writeByte(8)
      ..write(obj.fertilizingStartDate)
      ..writeByte(9)
      ..write(obj.fertilizingFrequency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
