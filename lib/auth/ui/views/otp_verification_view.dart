import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_otp_and_pin_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

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
              AppStrings.otpCodeVerification,
              style: AppTextStyles.bold28,
            ),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.otpCodeVerificationHint,
              style: AppTextStyles.regular16,
            ),
          ),
          const SizedBox(height: 24),
          CustomOtpAndPinWidget(
            onCompleted: (code) {},
            length: 6,
            isForPIN: false,
          ),
          const SizedBox(height: 32),
          const Align(
            child: Text(
              AppStrings.dontReceiveMail,
              style: AppTextStyles.medium14,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            child: Text(
              AppStrings.resendCode(32),
              style: AppTextStyles.medium14,
            ),
          ),
          const Expanded(child: SizedBox(height: 380)),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: AppStrings.next,
              backgroundColor: AppColors.primary,
              labelColor: Colors.white,
              onPressed: () {
                context.push(Routes.createNewPasswordView);
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
