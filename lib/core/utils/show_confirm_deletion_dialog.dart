import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> showConfirmDeletionDialog(BuildContext context, {int? index}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        elevation: 5,
        insetAnimationDuration: const Duration(milliseconds: 500),
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              const Text(
                AppStrings.goodJob,
                textAlign: TextAlign.center,
                style: AppTextStyles.bold20,
              ),
              Text(
                AppStrings.timeToSetSomeUserPrefs,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular16.copyWith(
                  color: AppColors.textContainer,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 8,
                children: [
                  Expanded(
                    child: CustomButton(
                      label: AppStrings.close,
                      backgroundColor: Colors.white,
                      labelColor: Colors.black,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      label: AppStrings.close,
                      backgroundColor: AppColors.primary,
                      labelColor: Colors.white,
                      onPressed: () {
                        /// TODO: Delete item
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
