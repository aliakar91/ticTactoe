import 'package:flutter/material.dart';

class AppTextStyle {
  static const voteAndVoterNumber = TextStyle(
    fontSize: 16.5,
    fontWeight: FontWeight.bold,
  );
  static const voteAndVoterText = TextStyle(
    fontSize: 15.3,
  );

  static alertDialogColorStyle({Color? color}) =>
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: color);

  static TextStyle boxText = TextStyle(
    color: Colors.grey.shade800,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
}
