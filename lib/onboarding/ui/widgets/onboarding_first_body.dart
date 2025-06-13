import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingFirstBody extends StatelessWidget {
  const OnboardingFirstBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        SvgPicture.asset(Assets.imagesOnboarding1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            context.tr(AppStrings.onboardingText1),
            style: AppTextStyles.bold28,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            context.tr(AppStrings.onboardingSubtext1),
            style: AppTextStyles.regular16,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
