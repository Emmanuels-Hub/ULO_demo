import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/theme_controller.dart';
import '../model/global.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: const Text(appName),),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Theme Mode',
                  style: TextStyle(
                    fontSize: 20,

                  ),),
                  IconButton(onPressed: () => themeController.toggleTheme(),
                      icon: Obx(() {
                        return Icon(
                          size: 40,
                          themeController.isDarkMode.value ?
                          Icons.toggle_off_outlined :
                          Icons.toggle_on_outlined,
                        );
                      }),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      }
  }

