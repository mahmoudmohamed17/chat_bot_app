import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class GenderItemWidget extends StatelessWidget {
  const GenderItemWidget({
    super.key,
    required this.text,
    required this.isActive,
  });
  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      curve: Curves.ease,
      decoration: ShapeDecoration(
        color: AppColors.container,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isActive ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: AppTextStyles.semiBold16),
          Visibility(
            visible: isActive,
            child: const Icon(Icons.check, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
