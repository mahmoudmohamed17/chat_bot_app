import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SelectLanguageItem extends StatelessWidget {
  const SelectLanguageItem({
    super.key,
    required this.text,
    required this.isActive,
  });
  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: isActive ? AppTextStyles.bold16 : AppTextStyles.regular16,
        ),
        Visibility(
          visible: isActive,
          child: const Icon(Icons.check, color: Colors.black),
        ),
      ],
    );
  }
}
