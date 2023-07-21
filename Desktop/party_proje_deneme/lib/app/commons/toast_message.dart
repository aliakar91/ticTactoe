import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

class LoginShowToastMessage {
  static showToastMessage(String text, {Color? color}) {
    return Toast.show(
      text,
      duration: 5,
      gravity: Toast.bottom,
      backgroundRadius: 60,
      backgroundColor: color ?? Colors.red,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
