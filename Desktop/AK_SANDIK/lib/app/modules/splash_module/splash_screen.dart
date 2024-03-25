import 'package:flutter/material.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';
import 'package:ak_sandik/app/globals/localizations/localization_keys.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        child: const Center(
          child: Text(
            LocalizationKeys.akSandik,
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
