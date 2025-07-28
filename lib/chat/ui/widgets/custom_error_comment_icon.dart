import 'package:animate_do/animate_do.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomErrorCommentIcon extends StatelessWidget {
  const CustomErrorCommentIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Column(
          spacing: 8,
          children: [
            Icon(Icons.error, color: Colors.red),
            Text('Can\'t send message', style: AppTextStyles.regular12),
          ],
        ),
      ),
    );
  }
}
