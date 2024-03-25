import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String text;
  final double? fontSize;

  const AppBarTitle({
    required this.text,
    this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize ?? 30,
      ),
    );
  }
}
