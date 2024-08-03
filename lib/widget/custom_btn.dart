import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomBtn({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              elevation: 0,
              backgroundColor: Colors.blue,
              textStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              minimumSize: const Size(40, 50)),
          onPressed: onTap,
          child: Text(text, style: const TextStyle(color: Colors.white),)),
    );
  }
}
