import 'package:chat_bot_app/auth/ui/views/create_new_password_view.dart';
import 'package:chat_bot_app/auth/ui/views/init_auth_view.dart';
import 'package:chat_bot_app/auth/ui/views/otp_verification_view.dart';
import 'package:chat_bot_app/auth/ui/views/reset_password_view.dart';
import 'package:chat_bot_app/auth/ui/views/signin_view.dart';
import 'package:chat_bot_app/auth/ui/views/signup_view.dart';
import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/onboarding/ui/views/onboarding_view.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouting {
  static final GoRouter router = GoRouter(
    initialLocation:
        SharedPrefs.getBool(isOnboardingSeen)
            ? Routes.initAuthView
            : Routes.onboardingView,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.onboardingView,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingView();
        },
      ),
      GoRoute(
        path: Routes.initAuthView,
        builder: (BuildContext context, GoRouterState state) {
          return const InitAuthView();
        },
      ),
      GoRoute(
        path: Routes.signinView,
        builder: (BuildContext context, GoRouterState state) {
          return const SigninView();
        },
      ),
      GoRoute(
        path: Routes.signupView,
        builder: (BuildContext context, GoRouterState state) {
          return const SignupView();
        },
      ),
      GoRoute(
        path: Routes.resetPasswordView,
        builder: (BuildContext context, GoRouterState state) {
          return const ResetPasswordView();
        },
      ),
      GoRoute(
        path: Routes.otpVerificationView,
        builder: (BuildContext context, GoRouterState state) {
          return const OtpVerificationView();
        },
      ),
      GoRoute(
        path: Routes.createNewPasswordView,
        builder: (BuildContext context, GoRouterState state) {
          return const CreateNewPasswordView();
        },
      ),
    ],
  );
}
