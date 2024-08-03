import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import '../chat_objects/chat_video.dart';
import '../controller/video_controller.dart';
import '../model/func.dart';
import '../widget/dialogBox.dart';

class VideoChat extends StatefulWidget {
  const VideoChat({super.key});

  @override
  State<VideoChat> createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  final TextEditingController _controller = TextEditingController();
  final VideoController videoController = Get.put(VideoController());
  FilePickerResult? result;
  bool hasPicked = false;
  bool isLoading = false;
  PlatformFile? filePath;

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
                  videoController.clearMessages();
                },
                onCancel: () {
                  Get.back();
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => ListView.builder(
              controller: videoController.scroll,
              physics: const BouncingScrollPhysics(),
              itemCount: videoController.messages.length,
              itemBuilder: (context, index) {
                final chat = videoController.messages[index];
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
                              IconButton(
                                  onPressed: () => copyText(chat.part),
                                  icon: const Icon(
                                    Icons.copy_sharp,
                                    size: 20,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Container(
                              constraints: const BoxConstraints(maxWidth: 270),
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.zero,
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                              child: chat.part.isNotEmpty
                                  ? Text(
                                      chat.part,
                                      style:
                                          const TextStyle(color: Colors.white),
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
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.zero,
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                            ),
                            child: Column(
                              children: [
                                if (chat.videoPath != null)
                                  IconButton(
                                    icon:const Icon(Icons.video_collection),
                                    iconSize: 100,
                                    onPressed: () {
                                      OpenFile.open(chat.videoPath);
                                    },),
                                 Text(
                                    chat.part,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const CircleAvatar(
                            child: Icon(Icons.person),
                          )
                        ],
                      );
              },
            ),
          )),
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
                    icon: hasPicked
                        ? const Icon(Icons.video_collection)
                        : const Icon(Icons.attach_file),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(type: FileType.video);
                      if (result != null){
                        setState(() {
                          hasPicked = true;
                          filePath = result.files.first;
                        });
                      }
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide.none, // This removes the border
                        ),
                        filled: true, // To give a slight background color
                        // contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                    ),
                  ),
                  isLoading
                      ? const Icon(Icons.stop_circle)
                      : IconButton(
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
                                final newFile = await videoController.saveFile(filePath);
                                videoController.addMessage(ChatVideo(role: 'user', part: text, videoPath: newFile.path));
                                pathStr = newFile;
                              }
                              else{
                                videoController.addMessage(ChatVideo(role: 'user', part: text));
                              }
                              videoController.addMessage(ChatVideo(role: 'bot', part: ''));
                              videoController.scrolldown();
                              _controller.clear();
                              final data = await videoController.getMessage(text, pathStr);
                              videoController.lastMessage();
                              videoController.addMessage(ChatVideo(role: 'bot', part: data!));
                              videoController.scrolldown();
                              setState(() {
                                hasPicked = false;
                                isLoading = false;
                                filePath = null;
                              });
                            }
                          }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
