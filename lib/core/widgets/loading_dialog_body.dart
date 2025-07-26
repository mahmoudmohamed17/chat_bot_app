import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_dialog_badge.dart';
import 'package:flutter/material.dart';

class LoadingDialogBody extends StatelessWidget {
  const LoadingDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderOnForeground: false,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomDialogBadge(icon: Icons.check),
            const SizedBox(height: 12),
            const Text(AppStrings.hadVeryLittle, style: AppTextStyles.bold18),
            const SizedBox(height: 8),
            Text(
              AppStrings.redirectToHomePageMessage,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.textContainer,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
