import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_password_form_field.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
            child: Text(
              AppStrings.createNewPassword,
              style: AppTextStyles.bold28,
            ),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.createNewPasswordHint,
              style: AppTextStyles.regular16,
            ),
          ),
          const SizedBox(height: 32),
          CustomPasswordFormField(
            hintText: AppStrings.newPassword,
            controller: passwordController,
          ),
          const SizedBox(height: 12),
          CustomPasswordFormField(
            controller: confirmPasswordController,
            hintText: AppStrings.confirmNewPassword,
          ),
          const Expanded(child: SizedBox(height: 400)),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: AppStrings.textContinue,
              backgroundColor: AppColors.primary,
              labelColor: Colors.white,
              onPressed: () {
                /// After creating a new password, navigate to home view
                /// context.push(Routes.createNewPasswordView);
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
