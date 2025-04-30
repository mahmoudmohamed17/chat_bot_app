import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_password_form_field.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_social_button.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_checkout_hint_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

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
            child: Text(AppStrings.welcome, style: AppTextStyles.bold28),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(AppStrings.signInHint, style: AppTextStyles.regular16),
          ),
          const SizedBox(height: 24),
          const CustomTextFormField(hintText: AppStrings.emailAddress),
          const SizedBox(height: 12),
          const CustomPasswordFormField(hintText: AppStrings.password),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: CustomCheckoutHintWidget(hint: AppStrings.rememberMe),
          ),
          const SizedBox(height: 24),
          Align(
            child: TextButton(
              onPressed: () {
                context.push(Routes.resetPasswordView);
              },
              child: Text(
                AppStrings.forgotPassword,
                style: AppTextStyles.semiBold14.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const Expanded(child: SizedBox(height: 150)),
          CustomSocialButton(
            label: AppStrings.continueWithGoogle,
            image: Assets.imagesGoogle,
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          CustomSocialButton(
            label: AppStrings.continueWithApple,
            image: Assets.imagesApple,
            onPressed: () {},
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: AppStrings.signIn,
              backgroundColor: AppColors.primary,
              labelColor: Colors.white,
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
