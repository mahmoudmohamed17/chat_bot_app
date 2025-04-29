import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(AppStrings.resetPassword, style: AppTextStyles.bold28),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.resetPasswordHint,
              style: AppTextStyles.regular16,
            ),
          ),
          const SizedBox(height: 24),
          const CustomTextFormField(hintText: 'Email Address'),
          const Expanded(child: SizedBox(height: 470)),
          CustomButton(
            label: AppStrings.textContinue,
            backgroundColor: AppColors.primary,
            labelColor: Colors.white,
            onPressed: () {},
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
