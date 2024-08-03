import 'package:hive/hive.dart';

part 'chat_geometry.g.dart';

@HiveType(typeId: 3)
class ChatGeometry extends HiveObject {
  @HiveField(0)
  late String role;

  @HiveField(1)
  late String part;

  @HiveField(2)
  late String? filePath;

  ChatGeometry({required this.role, required this.part, this.filePath});
}
