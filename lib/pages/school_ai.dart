import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ulo/chat_objects/school_assistance.dart';
import '../controller/school_controller.dart';
import '../model/global.dart';
import '../widget/dialogBox.dart';

class SchoolChat extends StatefulWidget {
  const SchoolChat({super.key});

  @override
  State<SchoolChat> createState() => _SchoolChatState();
}

class _SchoolChatState extends State<SchoolChat> {
  final TextEditingController _controller = TextEditingController();
  final SchoolController schoolController = Get.put(SchoolController());
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
                  schoolController.clearMessages();
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
                  controller: schoolController.scroll,
                  physics: const BouncingScrollPhysics(),
                  itemCount: schoolController.messages.length,
                  itemBuilder: (context, index) {
                    final chat = schoolController.messages[index];
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
                        schoolController.addMessage(SchoolAssistance(role: 'user', part: text));
                        schoolController.addMessage(SchoolAssistance(role: 'bot', part: ''));
                        schoolController.scrolldown();
                        _controller.clear();
                        final data = await schoolController.getMessage(text);
                        schoolController.lastMessage();
                        schoolController.addMessage(SchoolAssistance(role: 'bot', part: data! ));
                        schoolController.scrolldown();
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
