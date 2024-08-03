// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_assistance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatAssistanceAdapter extends TypeAdapter<ChatAssistance> {
  @override
  final int typeId = 0;

  @override
  ChatAssistance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatAssistance(
      role: fields[0] as String,
      part: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatAssistance obj) {
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
      other is ChatAssistanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
