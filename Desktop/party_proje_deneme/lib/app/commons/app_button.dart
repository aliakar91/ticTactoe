import 'package:flutter/material.dart';
import 'package:party_proje_deneme/app/globals/styles/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? color;
  final StadiumBorder? stadiumBorder;
  final IconData? icon;
  final double? size;
  final bool isWidget;
  final double? width;
  final MainAxisSize mainAxisSize;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.stadiumBorder,
    this.icon,
    this.size,
    this.isWidget = false,
    this.width,
    this.mainAxisSize = MainAxisSize.min,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color ?? AppColors.primary,
          shape: stadiumBorder,
        ),
        child: isWidget
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: mainAxisSize,
                children: [
                  Icon(
                    icon,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: size ?? 15),
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: TextStyle(fontSize: size ?? 15),
              ),
      ),
    );
  }
}
