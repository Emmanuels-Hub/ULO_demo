// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_audio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatAudioAdapter extends TypeAdapter<ChatAudio> {
  @override
  final int typeId = 1;

  @override
  ChatAudio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatAudio(
      role: fields[0] as String,
      part: fields[1] as String,
      filePath: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatAudio obj) {
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
      other is ChatAudioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
