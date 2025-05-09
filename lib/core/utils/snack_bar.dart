import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

snackBar(BuildContext context, {required String title, int timeInSeconds = 4}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: timeInSeconds),
      content: Text(
        title,
        style: AppTextStyles.regular16.copyWith(color: Colors.white),
      ),
    ),
  );
}
