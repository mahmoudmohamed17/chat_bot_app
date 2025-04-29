import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingFirstBody extends StatelessWidget {
  const OnboardingFirstBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        SvgPicture.asset(Assets.imagesOnboarding1),
        Text(AppStrings.onboardingText1, style: AppTextStyles.bold16),
        Text(AppStrings.onboardingSubtext1, style: AppTextStyles.medium14),
      ],
    );
  }
}
