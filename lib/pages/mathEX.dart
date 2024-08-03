import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import '../chat_objects/chat_geometry.dart';
import '../controller/math_controller.dart';
import '../model/func.dart';
import '../widget/dialogBox.dart';

class ChatMath extends StatefulWidget {
  const ChatMath({super.key});

  @override
  State<ChatMath> createState() => _ChatMathState();
}

class _ChatMathState extends State<ChatMath> {
  final TextEditingController _controller = TextEditingController();
  final MathController mathController = Get.put(MathController());
  FilePickerResult? result;
  bool hasPicked = false;
  bool isLoading = false;
  PlatformFile? filePath;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  mathController.clearMessages();
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
                  controller: mathController.scroll,
                  physics: const BouncingScrollPhysics(),
                  itemCount: mathController.messages.length,
                  itemBuilder: (context, index) {
                    final chat = mathController.messages[index];
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
                            child: chat.part.isNotEmpty ? Text(
                              chat.part,
                              style: const TextStyle(color: Colors.white),
                            ):
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
                          child: Column(
                            children:
                            [
                              if (chat.filePath != null)
                                GestureDetector(
                                  onTap: ()=>
                                      OpenFile.open(chat.filePath!),
                                  child: Image.file(
                                    File(chat.filePath!),
                                    height: 200,
                                  ),
                                ),
                              const SizedBox(height: 10,),
                              Text(
                                chat.part,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
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
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: hasPicked  ? const Icon(Icons.video_collection): const Icon(Icons.attach_file),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                          type: FileType.image);
                      setState(() {
                        hasPicked = true;
                        filePath = result!.files.first;
                      });
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none, // This removes the border
                        ),
                        filled: true, // To give a slight background color
                        // contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          File? pathStr;
                          if (filePath != null)
                          {
                            final newFile = await mathController.saveFile(filePath);
                            mathController.addMessage(ChatGeometry(role: 'user', part: text, filePath: newFile.path));
                            pathStr = newFile;
                          }
                          else{
                            mathController.addMessage(ChatGeometry(role: 'user', part: text));
                          }
                          mathController.addMessage( ChatGeometry(role: 'bot', part: ''));
                          mathController.scrolldown();
                          _controller.clear();
                          final data = await mathController.getMessage(text, pathStr);
                          mathController.lastMessage();
                          mathController.addMessage(ChatGeometry(role: 'bot', part: data!));
                          mathController.scrolldown();
                          setState(() {
                            hasPicked = false;
                            isLoading = false;
                            filePath = null;
                          });
                        }
                      }
                  ),
                ],
              ),
            )
            ,
          ),
        ],
      ),
    );
  }
}
