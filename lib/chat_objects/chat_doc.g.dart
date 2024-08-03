// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_doc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatDocAdapter extends TypeAdapter<ChatDoc> {
  @override
  final int typeId = 2;

  @override
  ChatDoc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatDoc(
      role: fields[0] as String,
      part: fields[1] as String,
      filePath: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatDoc obj) {
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
      other is ChatDocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
