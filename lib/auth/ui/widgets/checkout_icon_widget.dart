import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CheckoutIconWidget extends StatelessWidget {
  const CheckoutIconWidget({super.key});

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
      child: const Icon(Icons.check, size: 32, color: Colors.white),
    );
  }
}
