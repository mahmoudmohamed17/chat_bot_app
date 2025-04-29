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
      spacing: 4,
      children: [
        SvgPicture.asset(Assets.imagesOnboarding1),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            AppStrings.onboardingText1,
            style: AppTextStyles.bold28,
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            AppStrings.onboardingSubtext1,
            style: AppTextStyles.regular16,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
