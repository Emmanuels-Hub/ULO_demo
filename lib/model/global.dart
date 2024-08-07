import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//app name
const appName = 'Ulo AI';

//media query to store size of device screen
late Size mq;

String serverUrl = "https://bevel-ai.onrender.com/";

void copyText(text) {
  FlutterClipboard.copy(text)
      .then((value) => Get.snackbar('Hey There', 'Text Copied'));
}
