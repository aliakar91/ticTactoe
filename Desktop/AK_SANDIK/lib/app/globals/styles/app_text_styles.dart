import 'package:ak_sandik/app/globals/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static voteNumberStyle({
    Color? color,
    double? fontSize,
  }) =>
      TextStyle(
        fontSize: fontSize ?? 16.sp,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static voteAndVoterText() => TextStyle(
        fontSize: 15.sp,
      );

  static alertDialogStyle({Color? color}) => TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static cityNameStyle() => TextStyle(
        color: AppColors.greyShade700,
        fontWeight: FontWeight.w500,
        fontSize: 18.5,
      );

  static ballotBoxNo() => const TextStyle(
        fontSize: 20.5,
        fontWeight: FontWeight.bold,
      );

  static ballotBoxHasDone() => TextStyle(
      fontSize: 15.5, fontWeight: FontWeight.w500, color: Colors.red.shade600);

  static mayorContentHeader() => TextStyle(
        fontSize: 20.sp,
        color: AppColors.greyShade700,
        fontWeight: FontWeight.bold,
      );
}
