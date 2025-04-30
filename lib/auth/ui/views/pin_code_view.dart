import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_otp_and_pin_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class PinCodeView extends StatelessWidget {
  const PinCodeView({super.key});

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
            child: Text(AppStrings.setYourPINCode, style: AppTextStyles.bold28),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.setYourPINCodeHint,
              style: AppTextStyles.regular16,
            ),
          ),
          const SizedBox(height: 24),
          CustomOtpAndPinWidget(
            onCompleted: (code) {},
            length: 4,
            isForPIN: true,
          ),
          const Expanded(child: SizedBox(height: 470)),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: AppStrings.confirm,
              backgroundColor: AppColors.primary,
              labelColor: Colors.white,
              onPressed: () {
                /// Navigate to Home Screen
                // context.push(Routes.createNewPasswordView);
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
