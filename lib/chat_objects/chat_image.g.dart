// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatImageAdapter extends TypeAdapter<ChatImage> {
  @override
  final int typeId = 4;

  @override
  ChatImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatImage(
      role: fields[0] as String,
      part: fields[1] as String,
      filePath: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.role)
      ..writeByte(1)
      ..write(obj.part)
      ..writeByte(2)
      ..write(obj.filePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
