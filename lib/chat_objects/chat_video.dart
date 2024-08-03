import 'package:hive/hive.dart';

part 'chat_video.g.dart';

@HiveType(typeId: 5)
class ChatVideo extends HiveObject {
  @HiveField(0)
  late String role;

  @HiveField(1)
  late String part;

  @HiveField(2)
  late String? videoPath;

  ChatVideo({required this.role, required this.part, this.videoPath});
}
