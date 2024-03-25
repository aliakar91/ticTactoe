import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ak_sandik/app/commons/app_media_query.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';

class SendVoteButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? color;
  final StadiumBorder? stadiumBorder;
  final IconData? icon;
  final double? size;
  final bool isWidget;
  final double? width;
  final MainAxisSize mainAxisSize;
  final Color? textColor;

  const SendVoteButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.stadiumBorder,
    this.icon,
    this.size,
    this.isWidget = false,
    this.width,
    this.mainAxisSize = MainAxisSize.min,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppMediaQuery.width(0.13, context),
        right: AppMediaQuery.width(0.13, context),
        bottom: 10,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primary,
          shape: stadiumBorder ?? const RoundedRectangleBorder(),
        ),
        child: isWidget
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: mainAxisSize,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: size ?? 15,
                        color: textColor ?? Colors.white,
                      ),
                    ),
                  ),
                  Icon(icon, color: Colors.white, size: 18),
                ],
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: size ?? 15,
                  color: textColor ?? Colors.white,
                ),
              ),
      ),
    );
  }
}
