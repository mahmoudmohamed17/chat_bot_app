import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_checkout_hint_widget.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_password_form_field.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_social_button.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
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
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(AppStrings.welcome, style: AppTextStyles.bold28),
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(AppStrings.signInHint, style: AppTextStyles.regular16),
          ),
          const SizedBox(height: 24),
          CustomTextFormField(
            hintText: AppStrings.emailAddress,
            controller: widget.emailController,
          ),
          const SizedBox(height: 12),
          CustomPasswordFormField(
            hintText: AppStrings.password,
            controller: widget.passwordController,
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: CustomCheckoutHintWidget(hint: AppStrings.rememberMe),
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
          const Expanded(child: SizedBox(height: 140)),
          CustomSocialButton(
            label: AppStrings.continueWithGoogle,
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
            label: AppStrings.continueWithApple,
            image: Assets.imagesApple,
            onPressed: () {},
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              label: AppStrings.signIn,
              backgroundColor: AppColors.primary,
              labelColor: Colors.white,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var email = widget.emailController.text;
                  var password = widget.passwordController.text;
                  context.read<AuthCubit>().logIn(
                    email: email,
                    password: password,
                  );
                } else {
                  autovalidateMode = AutovalidateMode.always;
                }
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
