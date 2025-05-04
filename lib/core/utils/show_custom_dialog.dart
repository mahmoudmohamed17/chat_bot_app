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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              SvgPicture.asset(Assets.imagesBotAndHuman, height: 50, width: 50),
              const Text(AppStrings.goodJob, style: AppTextStyles.bold18),
              Text(
                AppStrings.timeToSetSomeUserPrefs,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.textContainer,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      label: 'Ok!',
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
