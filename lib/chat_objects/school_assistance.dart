import 'package:hive/hive.dart';

part 'school_assistance.g.dart';

@HiveType(typeId: 5)
class SchoolAssistance extends HiveObject {
  @HiveField(0)
  late String role;

  @HiveField(1)
  late String part;

  SchoolAssistance({required this.role, required this.part});
}
