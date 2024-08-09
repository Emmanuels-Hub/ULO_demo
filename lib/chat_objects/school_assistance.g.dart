// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_assistance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchoolAssistanceAdapter extends TypeAdapter<SchoolAssistance> {
  @override
  final int typeId = 5;

  @override
  SchoolAssistance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolAssistance(
      role: fields[0] as String,
      part: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SchoolAssistance obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.role)
      ..writeByte(1)
      ..write(obj.part);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolAssistanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
