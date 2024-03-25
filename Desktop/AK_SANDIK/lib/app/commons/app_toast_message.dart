import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

class AppToastMessage {
  static showSuccessMessage(String text,
      {Color? backgroundColor, int? gravity, int? duration}) {
    return Toast.show(
      text,
      duration: duration ?? 3,
      gravity: gravity ?? Toast.bottom,
      backgroundRadius: 60,
      backgroundColor: Colors.green,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  static showErrorMessage(String text, {int? gravity, int? duration}) {
    return Toast.show(
      text,
      duration: duration ?? 3,
      gravity: gravity ?? Toast.bottom,
      backgroundRadius: 60,
      backgroundColor: Colors.red,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
