import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_otp_and_pin_widget.dart';
import 'package:chat_bot_app/auth/ui/widgets/resend_code_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess && context.read<AuthCubit>().code != null) {
            context.push(Routes.createNewPasswordView, extra: email);
          }

          if (state is AuthFailed) {
            snackBar(context, title: state.errorMsg);
          }
        },
        builder: (context, state) {
          var cubit = context.read<AuthCubit>();
          return ModalProgressHUD(
            inAsyncCall: state is AuthLoading,
            child: Scaffold(
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
                    onCompleted: (code) {
                      cubit.code = code;
                    },
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
                  Align(child: ResendCodeWidget(email: email)),
                  const Expanded(child: SizedBox(height: 380)),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      label: AppStrings.next,
                      backgroundColor: AppColors.primary,
                      labelColor: Colors.white,
                      onPressed: () {
                        cubit.verifyOTP(email: email, token: cubit.code!);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
