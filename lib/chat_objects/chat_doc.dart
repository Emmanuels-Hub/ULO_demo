import 'package:hive/hive.dart';

part 'chat_doc.g.dart';

@HiveType(typeId: 2)
class ChatDoc extends HiveObject {
  @HiveField(0)
  late String role;

  @HiveField(1)
  late String part;

  @HiveField(2)
  late String? filePath;

  ChatDoc({required this.role, required this.part, this.filePath});
}
