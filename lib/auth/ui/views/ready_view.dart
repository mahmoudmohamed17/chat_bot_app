import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/dummy.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/core/widgets/custom_dialog_badge.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ReadyView extends StatefulWidget {
  const ReadyView({super.key});

  @override
  State<ReadyView> createState() => _ReadyViewState();
}

class _ReadyViewState extends State<ReadyView> {
  ConfettiController confettiController = ConfettiController(
    duration: const Duration(seconds: 6),
  )..play();
  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt.get<AuthCubit>()),
        BlocProvider.value(value: getIt.get<UsersCubit>()),
      ],
      child: ConfettiWidget(
        confettiController: confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        maxBlastForce: 30,
        minBlastForce: 20,
        emissionFrequency: 0.6,
        numberOfParticles: 20,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              SharedPrefs.setBool(isUserAuthenticated, true);
              SharedPrefs.setInt(selectedLangIndex, 0);
              context.go(Routes.mainView);
            }
            if (state is AuthFailed) {
              snackBar(context, title: state.errorMsg);
            }
          },
          builder: (context, state) {
            final authCubit = context.read<AuthCubit>();
            final usersCubit = context.read<UsersCubit>();
            return ModalProgressHUD(
              inAsyncCall: state is AuthLoading,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          CustomDialogBadge(icon: Icons.check),
                          Text(
                            AppStrings.youAreReady,
                            style: AppTextStyles.bold28,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            AppStrings.youAreReadyHint,
                            style: AppTextStyles.regular18,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          label: 'Go to Home',
                          backgroundColor: AppColors.primary,
                          labelColor: Colors.white,
                          onPressed: () async {
                            await authCubit.logIn(
                              email:
                                  authCubit.currentUser?.email ??
                                  dummyUserEmail,
                              password: authCubit.password ?? '',
                              getUser: usersCubit.getUser,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
