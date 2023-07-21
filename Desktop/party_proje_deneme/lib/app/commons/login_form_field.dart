import 'package:flutter/material.dart';

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
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onTap: onTap,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlignVertical: TextAlignVertical.center,
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              helperStyle: const TextStyle(
                fontSize: 13,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.cyan,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: icon,
              hintText: hintText,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.shade500,
                ),
                borderRadius: BorderRadius.circular(12), //<-- SEE HERE
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
