import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ak_sandik/app/globals/styles/app_colors.dart';

class AppFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? errorMessage;
  final String hintText;
  final Widget icon;
  final int? maxInputLength;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final int? minInputLength;
  final int? requiredInputLength;

  const AppFormField({
    super.key,
    this.controller,
    this.labelText,
    this.errorMessage,
    required this.hintText,
    required this.icon,
    this.maxInputLength,
    this.onTap,
    this.keyboardType,
    this.minInputLength,
    this.requiredInputLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onTap: onTap,
            style: const TextStyle(fontSize: 16),
            maxLength: maxInputLength,
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              helperStyle: const TextStyle(fontSize: 14),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: icon,
              prefixIconColor: AppColors.greyShade700,
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.greyShade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? validator(value) {
    if (requiredInputLength != null && value!.length < requiredInputLength!) {
      return errorMessage;
    } else if (value?.length == 0) {
      return errorMessage ?? "Bu alan boş bırakılamaz!";
    } else {
      return null;
    }
  }
}
