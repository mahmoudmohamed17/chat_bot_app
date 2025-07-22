import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_checkout_hint_widget.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_password_form_field.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_social_button.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/extensions/context_extension.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final usersCubit = context.read<UsersCubit>();
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
                context.tr(AppStrings.welcome),
                style: AppTextStyles.bold28,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.tr(AppStrings.signInHint),
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
                hint: context.tr(AppStrings.rememberMe),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              child: TextButton(
                onPressed: () {
                  context.push(Routes.resetPasswordView);
                },
                child: Text(
                  AppStrings.forgotPassword,
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.height * 0.14),
            CustomSocialButton(
              label: context.tr(AppStrings.continueWithGoogle),
              image: Assets.imagesGoogle,
              onPressed: () {
                authCubit.signInWithGoogle(
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
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: context.tr(AppStrings.signIn),
                backgroundColor: AppColors.primary,
                labelColor: Colors.white,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final email = widget.emailController.text;
                    final password = widget.passwordController.text;
                    context.read<AuthCubit>().logIn(
                      email: email,
                      password: password,
                      getUser: usersCubit.getUser,
                    );
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
