import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/signup_view_body.dart';
import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt.get<AuthCubit>()),
        BlocProvider.value(value: getIt.get<UsersCubit>()),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.push(Routes.selectGenderView);
            clear();
          }

          if (state is AuthFailed) {
            snackBar(context, title: state.errorMsg);
          }

          if (state is GoogleAuthSuccess) {
            SharedPrefs.setBool(isUserAuthenticated, true);
            SharedPrefs.setInt(selectedLangIndex, 0);
            context.go(Routes.mainView);
          }

          if (state is AuthFailed) {
            snackBar(context, title: state.errorMsg);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is AuthLoading || state is GoogleAuthLoading,
            child: Scaffold(
              appBar: customAppBar(context),
              body: SignupViewBody(
                emailController: emailController,
                passwordController: passwordController,
              ),
            ),
          );
        },
      ),
    );
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
  }
}
