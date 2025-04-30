import 'dart:developer';

import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/gender_selection_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectGenderView extends StatelessWidget {
  const SelectGenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(AppStrings.yourGender, style: AppTextStyles.bold28),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.yourGenderHint,
              style: AppTextStyles.regular16,
            ),
          ),
          const SizedBox(height: 24),
          GenderSelectionWidget(
            onSelectedGender: (gender) {
              log('Gender: $gender');
            },
          ),
          const Expanded(child: SizedBox(height: 350)),
          CustomButton(
            label: AppStrings.next,
            backgroundColor: AppColors.primary,
            labelColor: Colors.white,
            onPressed: () {
              /// After selecting gender, setup some personal user data
              context.push(Routes.personalInfoView);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
