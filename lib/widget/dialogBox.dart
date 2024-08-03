import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

void showLottieDialog() {
  Get.dialog(
    Center(
      child: Lottie.asset(
        'assets/robo.json',
        width: 150,
        height: 150,
      ),
    ),
    barrierDismissible: false,
  );
}


void showConfirmationDialog({
  required String title,
  required String message,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
}) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onCancel ?? Get.back,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Get.back();
          },
          child: const Text('Confirm'),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

