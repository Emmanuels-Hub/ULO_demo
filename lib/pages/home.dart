import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'setting.dart';

import 'ai_task.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Lottie.asset(
                          'assets/robo.json',
                          width: 70,
                          height: 70,
                        ),
                        // const SizedBox(width: 2,),
                        const Text('Welcome User!',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Get.to(() => const Setting());
                        },
                        icon: const Icon(Icons.menu_outlined),
                    )
                  ],
                ),
                const SizedBox(height: 7,),
                const Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('What Can i do',
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                        Text('for you?',
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Task(),
                  ],
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}
