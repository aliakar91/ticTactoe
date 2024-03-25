import 'package:flutter/material.dart';

class VoteButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final Color fillColor;

  const VoteButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape:  const CircleBorder(),
      fillColor: fillColor,
      padding: const EdgeInsets.all(14.0),
      child: Icon(
        icon,
        //size: 16,
        size: 22,
        color: Colors.white,
      ),
    );
  }
}
