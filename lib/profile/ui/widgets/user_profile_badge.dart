import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class UserProfileBadge extends StatelessWidget {
  const UserProfileBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.zero,

      /// TODO: Display image with Image Picker Widget
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(Assets.imagesProfilePic),
      ),
      title: const Text(
        AppStrings.dummyUsername,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.bold16,
      ),
      subtitle: Text(
        AppStrings.dummyUserEmail,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.regular12.copyWith(color: AppColors.textContainer),
      ),
    );
  }
}
