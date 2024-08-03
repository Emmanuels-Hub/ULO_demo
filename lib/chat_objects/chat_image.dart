import 'package:hive/hive.dart';

part 'chat_image.g.dart';

@HiveType(typeId: 4)
class ChatImage extends HiveObject {
  @HiveField(0)
  late String role;

  @HiveField(1)
  late String part;

  @HiveField(2)
  late String? filePath;

  ChatImage({required this.role, required this.part, this.filePath});
}
