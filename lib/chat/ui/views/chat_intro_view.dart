import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatIntroView extends StatelessWidget {
  const ChatIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          const Spacer(),
          Image.asset(Assets.imagesAppLogo, scale: 3),
          const Text(
            AppStrings.appName,
            style: AppTextStyles.bold24,
            textAlign: TextAlign.center,
          ),
          const Text(
            AppStrings.startChatHint,
            style: AppTextStyles.regular18,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: AppStrings.startChat,
              backgroundColor: AppColors.primary,
              labelColor: Colors.white,
              onPressed: () {
                context.push(Routes.newConversationView);
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
