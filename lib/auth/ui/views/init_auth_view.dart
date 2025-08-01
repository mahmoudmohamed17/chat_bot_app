import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitAuthView extends StatelessWidget {
  const InitAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Assets.imagesAppLogo, scale: 3),
                  Text(
                    context.tr(AppStrings.appName),
                    style: AppTextStyles.bold28,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 16,
                children: [
                  Expanded(
                    child: CustomButton(
                      label: context.tr(AppStrings.signUp),
                      onPressed: () {
                        context.push(Routes.signupView);
                      },
                      backgroundColor: Colors.white,
                      labelColor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      label: context.tr(AppStrings.signIn),
                      onPressed: () {
                        context.push(Routes.signinView);
                      },
                      backgroundColor: AppColors.primary,
                      labelColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }
}
