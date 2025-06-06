import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> showCustomDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (contex) {
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
              SvgPicture.asset(
                Assets.imagesBotAndHuman,
                height: 150,
                width: 150,
              ),
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
                children: [
                  Expanded(
                    child: CustomButton(
                      label: AppStrings.ok,
                      backgroundColor: AppColors.primary,
                      labelColor: Colors.white,
                      onPressed: () {
                        context.pop();
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
