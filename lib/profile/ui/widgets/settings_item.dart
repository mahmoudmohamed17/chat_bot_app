import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/profile/logic/models/settings_model.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.model});
  final SettingsModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.container,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 12,
          children: [
            Icon(
              model.icon,
              color: model.title == 'Log out' ? Colors.red : Colors.black,
            ),
            Text(
              model.title,
              style: AppTextStyles.semiBold16.copyWith(
                color: model.title == 'Log out' ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
