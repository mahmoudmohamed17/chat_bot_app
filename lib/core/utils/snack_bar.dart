import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

snackBar(BuildContext context, {required String title}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: AppTextStyles.regular16.copyWith(color: Colors.white),
      ),
    ),
  );
}
