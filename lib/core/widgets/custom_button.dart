import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.labelColor,
  });
  final String label;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 1,
        padding: const EdgeInsets.all(12),
      ),
      child: Text(
        label,
        style: AppTextStyles.medium16.copyWith(color: labelColor),
      ),
    );
  }
}
