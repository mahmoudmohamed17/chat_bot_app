import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/auth/ui/widgets/signin_view_body.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/loading_dialog_body.dart';
import 'package:chat_bot_app/core/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
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
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            clear();
          }
          if (state is AuthFailed) {
            snackBar(context, title: state.errorMsg);
          }
        },
        builder: (context, state) {
          return LoadingOverlayWidget(
            isLoading: state is AuthLoading,
            dialogBody: const LoadingDialogBody(),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: customAppBar(context),
              body: SigninViewBody(
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
