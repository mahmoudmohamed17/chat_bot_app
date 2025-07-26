import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/core/constants/localization_keys.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr(LocalizationKeys.aboutGemiChatBot),
                style: AppTextStyles.bold28,
              ),
              Text(
                context.tr(LocalizationKeys.aboutGemiChatBotText),
                style: AppTextStyles.regular14,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
