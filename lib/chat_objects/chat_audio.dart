import 'package:hive/hive.dart';

part 'chat_audio.g.dart';

@HiveType(typeId: 1)
class ChatAudio extends HiveObject {
  @HiveField(0)
  late String role;

  @HiveField(1)
  late String part;

  @HiveField(2)
  late String? filePath;

  ChatAudio({required this.role, required this.part, this.filePath});
}
