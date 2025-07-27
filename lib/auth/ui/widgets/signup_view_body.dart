import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_checkout_hint_widget.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_password_form_field.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_social_button.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/extensions/context_extension.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool _isTermsAndPolicyApproved = false;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.tr(AppStrings.createAccount),
                style: AppTextStyles.bold28,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.tr(AppStrings.createAccountHint),
                style: AppTextStyles.regular16,
              ),
            ),
            const SizedBox(height: 24),
            CustomTextFormField(
              hintText: context.tr(AppStrings.emailAddress),
              controller: widget.emailController,
            ),
            const SizedBox(height: 12),
            CustomPasswordFormField(
              hintText: context.tr(AppStrings.password),
              controller: widget.passwordController,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomCheckoutHintWidget(
                hint: context.tr(AppStrings.confirmToPolicy),
                onSelected: (value) {
                  _isTermsAndPolicyApproved = value;
                },
              ),
            ),
            const SizedBox(height: 32),
            CustomSocialButton(
              label: context.tr(AppStrings.continueWithGoogle),
              image: Assets.imagesGoogle,
              onPressed: () {
                final usersCubit = context.read<UsersCubit>();
                context.read<AuthCubit>().signInWithGoogle(
                  addGoogleUser: usersCubit.addGoogleUser,
                  getUser: usersCubit.getUser,
                );
              },
            ),
            const SizedBox(height: 12),
            CustomSocialButton(
              label: context.tr(AppStrings.continueWithApple),
              image: Assets.imagesApple,
              onPressed: () {},
            ),
            SizedBox(height: context.height * 0.25),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: context.tr(AppStrings.next),
                backgroundColor: AppColors.primary,
                labelColor: Colors.white,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    if (_isTermsAndPolicyApproved) {
                      authCubit.password = widget.passwordController.text;
                      await authCubit.signUp(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } else {
                      snackBar(
                        context,
                        title: AppStrings.agreeToPolicyAlertMessage,
                      );
                    }
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                  }
                },
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
