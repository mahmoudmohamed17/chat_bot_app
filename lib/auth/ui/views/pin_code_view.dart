import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_otp_and_pin_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PinCodeView extends StatefulWidget {
  const PinCodeView({super.key});

  @override
  State<PinCodeView> createState() => _PinCodeViewState();
}

class _PinCodeViewState extends State<PinCodeView> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.tr(AppStrings.setYourPINCode),
                style: AppTextStyles.bold28,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.tr(AppStrings.setYourPINCodeHint),
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
                label: context.tr(AppStrings.confirm),
                backgroundColor: AppColors.primary,
                labelColor: Colors.white,
                onPressed: () async {
                  /// Navigate to Ready Screen [Before Home Screen]
                  setState(() {
                    _isLoading = true;
                  });
                  await Future.delayed(const Duration(seconds: 3), () {
                    setState(() {
                      _isLoading = false;
                    });
                  });
                  if (context.mounted) {
                    context.push(Routes.readyView);
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
