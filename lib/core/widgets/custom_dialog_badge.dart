import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDialogBadge extends StatelessWidget {
  const CustomDialogBadge({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.primaryExtraLight, AppColors.primaryLight],
        ),
      ),
      padding: const EdgeInsets.all(18),
      child: Icon(icon, size: 32),
    );
  }
}
