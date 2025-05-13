import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/core/widgets/custom_dialog_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

Future<dynamic> signoutConfirmDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context_) {
      return BlocProvider(
        create: (context) => getIt.get<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.go(Routes.initAuthView);
              SharedPrefs.setBool(isUserAuthenticated, false);
              context.pop();
            }
            if (state is AuthFailed) {
              snackBar(context, title: state.errorMsg);
              context.pop();
            }
          },
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
            return ModalProgressHUD(
              inAsyncCall: state is AuthLoading,
              child: Dialog(
                backgroundColor: Colors.white,
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 16,
                    children: [
                      const CustomDialogBadge(icon: Icons.error_outline),
                      const Text(
                        AppStrings.areYouSureToSignout,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bold16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 16,
                        children: [
                          Expanded(
                            child: CustomButton(
                              label: AppStrings.cancel,
                              backgroundColor: Colors.white,
                              labelColor: Colors.black,
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomButton(
                              label: AppStrings.signOut,
                              backgroundColor: AppColors.primary,
                              labelColor: Colors.white,
                              onPressed: () {
                                cubit.signOut();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
