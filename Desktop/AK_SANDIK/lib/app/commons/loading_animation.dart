import 'package:flutter/material.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: LoadingAnimationWidget.bouncingBall(
                size: 60,
                color: AppColors.primary,
              ),
            ),
            const Text(
              LocalizationKeys.verilerYukleniyor,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
