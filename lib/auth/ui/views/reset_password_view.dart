import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.push(
              Routes.otpVerificationView,
              extra: emailController.text,
            );
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.tr(AppStrings.resetPassword),
                      style: AppTextStyles.bold28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.tr(AppStrings.resetPasswordHint),
                      style: AppTextStyles.regular16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    hintText: context.tr(AppStrings.emailAddress),
                    controller: emailController,
                  ),
                  const Expanded(child: SizedBox(height: 470)),
                  CustomButton(
                    label: context.tr(AppStrings.next),
                    backgroundColor: AppColors.primary,
                    labelColor: Colors.white,
                    onPressed: () {
                      cubit.signInWithOTP(email: emailController.text);
                    },
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
