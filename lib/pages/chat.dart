import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../chat_objects/chat_assistance.dart';
import '../controller/chat_controller.dart';
import '../model/func.dart';
import '../widget/dialogBox.dart';

class ChatMe extends StatefulWidget {
  const ChatMe({super.key});

  @override
  State<ChatMe> createState() => _ChatMeState();
}

class _ChatMeState extends State<ChatMe> {
  final TextEditingController _controller = TextEditingController();
  final MessageController messageController = Get.put(MessageController());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Chat with Ulo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showConfirmationDialog(
                title: 'Confirm Action',
                message: 'Are you sure you want to clear up all chat?',
                onConfirm: () {
                  messageController.clearMessages();
                },
                onCancel: () {
                  Get.back();
                },
              );

            },
          ),
        ],
      ),
      body:  Column(
        children: [
          Expanded(
              child: Obx(
                    () => ListView.builder(
                      controller: messageController.scroll,
                      physics: const BouncingScrollPhysics(),
                itemCount: messageController.messages.length,
                itemBuilder: (context, index) {
                  final chat = messageController.messages[index];
                  return chat.role == 'bot'
                      ?
                      // bot
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            child: Lottie.asset(
                              'assets/robo.json',
                              width: 70,
                              height: 70,
                            ),
                          ),
                          IconButton(onPressed: () => copyText(chat.part),
                              icon: const Icon(
                                Icons.copy_sharp,
                                size: 20 ,

                              )
                          )
                        ],
                      ),
                      const SizedBox(width: 6,),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 270),
                        margin: const EdgeInsets.fromLTRB(0,5,0,5),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.zero,
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)
                          ),
                        ),
                        child: chat.part.isNotEmpty ?
                            RichText(
                                text:  TextSpan(
                                    text:
                                      chat.part,
                                      )
                            )
                            :
                        Lottie.asset(
                          'assets/typing.json',
                          width: 40,
                          height: 60,
                        ),
                      ),
                    ],
                  )
                  :
                  // user
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 270),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.fromLTRB(0,5,0,5),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.zero,
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)
                          ),
                        ),
                        child: Text(
                          chat.part,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 6,),
                      const CircleAvatar(
                        child: Icon(Icons.person
                        ),
                      )
                    ],
                  );
                },
              ),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                isLoading ?
                    const Icon(Icons.stop_circle)
                    :
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final text = _controller.text;
                    if (text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                    messageController.addMessage(ChatAssistance(role: 'user', part: text));
                    messageController.addMessage(ChatAssistance(role: 'bot', part: ''));
                    messageController.scrolldown();
                    _controller.clear();
                    final data = await messageController.getMessage(text);
                    messageController.lastMessage();
                    messageController.addMessage(ChatAssistance(role: 'bot', part: data! ));
                    messageController.scrolldown();
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

