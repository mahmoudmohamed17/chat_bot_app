import 'package:animate_do/animate_do.dart';
import 'package:chat_bot_app/core/extensions/context_extension.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class UserMessageBubble extends StatelessWidget {
  const UserMessageBubble({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: context.width * 0.65,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular16.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
