import 'package:chat_bot_app/auth/ui/widgets/checkout_icon_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ReadyView extends StatelessWidget {
  const ReadyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            const Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                CheckoutIconWidget(),
                Text(
                  AppStrings.youAreReady,
                  style: AppTextStyles.bold28,
                  textAlign: TextAlign.center,
                ),
                Text(
                  AppStrings.youAreReadyHint,
                  style: AppTextStyles.regular18,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: 'Go to Home',
                backgroundColor: AppColors.primary,
                labelColor: Colors.white,
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
