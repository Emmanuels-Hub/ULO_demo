import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DocQA.dart';
import 'vidQA.dart';
import 'ImgCom.dart';
import 'audCon.dart';
import 'chat.dart';
import 'mathEX.dart';

class Task extends StatelessWidget {
  const Task({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/slider/1.png'),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Education Assistant',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      Text('Chat with an Educational assistant')
                    ],
                  ),
                ],
              ),
              IconButton(
                  hoverColor: Colors.orange,
                  onPressed: (){
                    Get.to(()=> const ChatMe());
                  },
                  icon: const Icon(Icons.navigate_next, size: 30,)
              )
            ],
          ),
        ),
        Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/slider/2.png'),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Video QA',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      Text('Get Information from Video')
                    ],
                  ),
                ],
              ),
              IconButton(
                  hoverColor: Colors.orange,
                  onPressed: (){
                    Get.to(()=> const VideoChat());
                  },
                  icon: const Icon(Icons.navigate_next, size: 30,)
              )
            ],
          ),
        ),
        Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/slider/3.png'),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Audio Conversion',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      Text('Convert Audio to Text')
                    ],
                  ),
                ],
              ),
              IconButton(
                  hoverColor: Colors.orange,
                  onPressed: (){
                    Get.to( ()=> const ChatAud());
                  },
                  icon: const Icon(Icons.navigate_next, size: 30,)
              )
            ],
          ),
        ),
        Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/slider/4.png'),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Communicate with Image',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      Text('Identify Objects from Image')
                    ],
                  ),
                ],
              ),
              IconButton(
                  hoverColor: Colors.orange,
                  onPressed: (){
                    Get.to(()=> const ImageChat());
                  },
                  icon: const Icon(Icons.navigate_next, size: 30,)
              )
            ],
          ),
        ),
        Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/slider/6.png'),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Math Solutions',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      Text('Solve equations and geometry')
                    ],
                  ),
                ],
              ),
              IconButton(
                  hoverColor: Colors.orange,
                  onPressed: (){
                    Get.to( ()=> const ChatMath());
                  },
                  icon: const Icon(Icons.navigate_next, size: 30,)
              )
            ],
          ),
        ),
        Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/slider/5.png'),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Document QA',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      Text('Get information from Documents')
                    ],
                  ),
                ],
              ),
              IconButton(
                  hoverColor: Colors.orange,
                  onPressed: (){
                    Get.to( ()=> const ChatGeometry());
                  },
                  icon: const Icon(Icons.navigate_next, size: 30,)
              )
            ],
          ),
        ),
      ],
    );
  }
}
