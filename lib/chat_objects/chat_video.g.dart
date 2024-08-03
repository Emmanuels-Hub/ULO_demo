// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_video.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatVideoAdapter extends TypeAdapter<ChatVideo> {
  @override
  final int typeId = 5;

  @override
  ChatVideo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatVideo(
      role: fields[0] as String,
      part: fields[1] as String,
      videoPath: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatVideo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.role)
      ..writeByte(1)
      ..write(obj.part)
      ..writeByte(2)
      ..write(obj.videoPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatVideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
