import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/core/widgets/custom_dialog_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> signoutConfirmDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context_) {
      return Dialog(
        backgroundColor: Colors.white,
        elevation: 5,
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
              const CustomDialogBadge(icon: Icons.error_outline),
              const Text(
                AppStrings.areYouSureToSignout,
                textAlign: TextAlign.center,
                style: AppTextStyles.bold16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 16,
                children: [
                  Expanded(
                    child: CustomButton(
                      label: AppStrings.cancel,
                      backgroundColor: Colors.white,
                      labelColor: Colors.black,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      label: AppStrings.signOut,
                      backgroundColor: AppColors.primary,
                      labelColor: Colors.white,
                      onPressed: () {
                        context.pop();
                        context.read<AuthCubit>().signOut();
                        SharedPrefs.setBool(isUserAuthenticated, false);
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
