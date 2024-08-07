import 'dart:convert';
import 'dart:io';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import '../chat_objects/chat_audio.dart';
import '../model/global.dart';

class AudioController extends GetxController {
  var messages = <ChatAudio>[
    ChatAudio(role: 'bot', part: 'Hello, How can i help you today?')
  ].obs;
  final scroll = ScrollController();

  late Box<ChatAudio> chatBox = Hive.box<ChatAudio>('chat_audio');

  void loadMessages() {
    messages.addAll(chatBox.values);
  }

  void addMessage(ChatAudio message) {
    messages.add(message);
    chatBox.add(message);
  }

  void clearMessages() {
    messages.clear();
    chatBox.clear();
  }

  void lastMessage() {
    if (messages.isNotEmpty) {
      var lastMessage = messages.removeLast();
      chatBox.delete(lastMessage.key);
    }
  }

  void scrolldown() {
    scroll.animateTo(scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<File> saveFile(file) async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      // Permission granted, proceed with file operation
      final newFile = File(file.path);
      await FileSaver.instance
          .saveFile(name: file.name, file: newFile, filePath: newFile.path);
      return newFile;
    } else {
      // Permission denied, handle accordingly
      Get.snackbar('Storage status', 'Permission not granted');
      return file.path;
    }
  }

  List buildHistory() {
    return messages.map((message) {
      return {
        'role': message.role == 'bot' ? 'model' : 'user',
        'parts': message.part,
      };
    }).toList();
  }

  Future<String?> getMessage(msg, file) async {
    var timeout = 3;
    if (file != null) {
      String resData = 'Internet ERROR: Please resend previous message.';
      while (timeout >= 0) {
        try {
          var mimeType = lookupMimeType(file.path);
          var request = http.MultipartRequest(
              'POST', Uri.parse('${serverUrl}generate_media/'));
          request.files
              .add(await http.MultipartFile.fromPath('file', file!.path));
          request.fields['prompt'] = msg;
          request.fields['mime'] = mimeType!;
          request.headers['Content-Type'] = 'multipart/form-data';

          var response = await request.send();

          if (response.statusCode == 200) {
            final responseData = await response.stream.bytesToString();
            final data = responseData;
            resData = data;
            break;
          } else {
            // Handle the error accordingly
            timeout--;
          }
        } catch (e) {
          timeout--;
        }
      }
      return resData;
    } else {
      final res = promptMessage(msg);
      return res;
    }
  }

  Future<String?> promptMessage(msg) async {
    final history = buildHistory();
    var timeout = 3;

    String resData = 'Internet ERROR: Please resend previous message.';
    while (timeout >= 0) {
      try {
        var request = await http.post(
          Uri.parse('${serverUrl}generate/'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"prompt": msg, "history": history}),
        );

        if (request.statusCode == 200) {
          final data = request.body;
          resData = data;
          break;
        } else {
          timeout--;
        }
      } catch (e) {
        timeout--;
      }
    }
    return resData;
  }

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }
}
