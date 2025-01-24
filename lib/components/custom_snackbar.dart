import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 5), // 5초 후 사라짐
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
