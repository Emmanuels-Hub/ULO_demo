import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../chat_objects/chat_assistance.dart';

class MessageController extends GetxController {
  var messages = <ChatAssistance>[ChatAssistance(role: 'bot', part: 'Hello, How can i help you today?')].obs;
  final scroll = ScrollController();

  late Box<ChatAssistance> chatBox = Hive.box<ChatAssistance>('chat_assistance');

  void loadMessages() {
    messages.addAll(chatBox.values);
  }

  void addMessage(ChatAssistance message) {
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
    try{
      var request = await http.post(
        Uri.parse('https://bevel-ai.onrender.com/generate/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"prompt": msg, "history": history}),
      );

      if (request.statusCode == 200) {
        final data = request.body;
        return data;
      } else {
        return 'Failed to load data';
      }
    }
    catch(e){
      return 'Error Message: $e';
    }

  }

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

}