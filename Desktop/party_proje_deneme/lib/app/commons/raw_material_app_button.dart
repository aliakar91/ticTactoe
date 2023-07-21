import 'package:flutter/material.dart';

class RawMaterialAppButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final Color fillColor;

  const RawMaterialAppButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: fillColor,
      padding: const EdgeInsets.all(9.0),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
