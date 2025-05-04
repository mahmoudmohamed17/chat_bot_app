import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.onFieldSubmitted,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.controller,
  });
  final String hintText;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: AppTextStyles.regular16,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is required';
        } else {
          return null;
        }
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.regular16.copyWith(
          color: AppColors.textContainer,
        ),
        fillColor: AppColors.container,
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: Colors.transparent),
  );
}
