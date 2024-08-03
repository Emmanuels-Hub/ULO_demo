import 'package:hive/hive.dart';

part 'chat_assistance.g.dart';

@HiveType(typeId: 0)
class ChatAssistance extends HiveObject {
  @HiveField(0)
  late String role;

  @HiveField(1)
  late String part;

  ChatAssistance({required this.role, required this.part});
}
