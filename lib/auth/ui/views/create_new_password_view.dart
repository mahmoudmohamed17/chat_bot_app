import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_password_form_field.dart';
import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/core/widgets/loading_dialog_body.dart';
import 'package:chat_bot_app/core/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key, required this.email});
  final String email;

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            /// Navigate to Home Page
            context.go(Routes.mainView);
            SharedPrefs.setBool(isUserAuthenticated, true);
          }

          if (state is AuthFailed) {
            snackBar(context, title: state.errorMsg);
          }
        },
        builder: (context, state) {
          var cubit = context.read<AuthCubit>();
          return LoadingOverlayWidget(
            isLoading: state is AuthLoading,
            dialogBody: const LoadingDialogBody(),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: customAppBar(context),
              body: Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: ListView(
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
                          if (formKey.currentState!.validate()) {
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              snackBar(
                                context,
                                title: AppStrings.enterSamePasswordsAlert,
                              );
                            } else {
                              cubit.updateUser(
                                email: widget.email,
                                password: passwordController.text,
                              );
                            }
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
