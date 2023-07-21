import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    Key? key,
    required this.contentText,
    required this.confirmButtonText,
    required this.titleText,
    required this.onPressed,
  }) : super(key: key);
  final String contentText;
  final String confirmButtonText;
  final String titleText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titleText,
        style: const TextStyle(fontSize: 20),
      ),
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "İptal",
            style: TextStyle(color: Colors.black54, fontSize: 17),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            confirmButtonText,
            style: const TextStyle(color: Colors.black, fontSize: 17),
          ),
        ),
      ],
    );
  }
}
