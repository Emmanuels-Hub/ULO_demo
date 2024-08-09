import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:ulo/chat_objects/school_assistance.dart';
import '../model/global.dart';

class SchoolController extends GetxController {
  var messages = <SchoolAssistance>[SchoolAssistance(role: 'bot', part: 'Hello, How can i help you today?')].obs;
  final scroll = ScrollController();

  late Box<SchoolAssistance> chatBox = Hive.box<SchoolAssistance>('school_assistance');

  void loadMessages() {
    messages.addAll(chatBox.values);
  }

  void addMessage(SchoolAssistance message) {
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
  
  void scrolldown()
  {
    scroll.animateTo(scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  List buildHistory() {
    return messages.map((message) {
      return {
        'role': message.role == 'bot' ? 'model' : 'user',
        'parts': message.part,
      };
    }).toList();
  }

  Future<String?> getMessage(msg) async {
    final history = buildHistory();
    var timeout = 3;

    String resData = 'Internet ERROR: Please resend previous message.';
    while(timeout >= 0) {
      try {
        var request = await http.post(
          Uri.parse('${serverUrl}generate_school/Bevel/'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"prompt": msg, "history": history}),
        );

        if (request.statusCode == 200) {
          final data = request.body;
          resData = data;
          break;
        }
        else {
          timeout--;
        }
      }
      catch(e){
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

