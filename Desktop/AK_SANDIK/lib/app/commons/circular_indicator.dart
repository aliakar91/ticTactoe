import 'package:flutter/material.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}
