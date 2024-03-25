import 'package:flutter/material.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

class AppAlertDialog extends StatelessWidget {
  final String contentText;
  final Function() onPressed;

  const AppAlertDialog({
    super.key,
    required this.contentText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
         LocalizationKeys.eminMisiniz,
          style: TextStyle(
            fontSize: 22,
            color: Colors.red,
          ),
        ),
      ),
      content: Text(
        contentText,
        style: const TextStyle(fontSize: 20),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            LocalizationKeys.iptal,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 17,
            ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            LocalizationKeys.tamam,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
