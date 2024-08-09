import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ulo/chat_objects/school_assistance.dart';
import 'package:ulo/pages/splash_screen.dart';
import 'chat_objects/chat_assistance.dart';
import 'chat_objects/chat_audio.dart';
import 'chat_objects/chat_doc.dart';
import 'chat_objects/chat_geometry.dart';
import 'chat_objects/chat_image.dart';
import 'controller/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');

  Hive.registerAdapter(ChatAssistanceAdapter());
  Hive.registerAdapter(ChatImageAdapter());
  Hive.registerAdapter(ChatAudioAdapter());
  Hive.registerAdapter(ChatDocAdapter());
  Hive.registerAdapter(ChatGeometryAdapter());
  Hive.registerAdapter(SchoolAssistanceAdapter());

  await Hive.openBox<ChatAssistance>('chat_assistance');
  await Hive.openBox<ChatImage>('chat_image');
  await Hive.openBox<ChatAudio>('chat_audio');
  await Hive.openBox<ChatDoc>('chat_doc');
  await Hive.openBox<ChatGeometry>('chat_geometry');
  await Hive.openBox<SchoolAssistance>('school_assistance');

  final ThemeController themeController = Get.put(ThemeController());
  runApp(GetMaterialApp(
    title: 'Ulo',
    themeMode: themeController.theme,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    home: const Loading(),
  ));
}
