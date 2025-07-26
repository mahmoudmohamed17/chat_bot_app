import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/constants/localization_keys.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileViewAppBar extends StatelessWidget {
  const ProfileViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(Assets.imagesAppLogo, scale: 10.5),
        Text(
          context.tr(LocalizationKeys.myProfile),
          style: AppTextStyles.bold18,
        ),
        const SizedBox(width: 47.5),
      ],
    );
  }
}
