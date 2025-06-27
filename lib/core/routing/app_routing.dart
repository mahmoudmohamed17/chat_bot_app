import 'package:chat_bot_app/auth/ui/views/create_new_password_view.dart';
import 'package:chat_bot_app/auth/ui/views/init_auth_view.dart';
import 'package:chat_bot_app/auth/ui/views/otp_verification_view.dart';
import 'package:chat_bot_app/auth/ui/views/personal_info_view.dart';
import 'package:chat_bot_app/auth/ui/views/pin_code_view.dart';
import 'package:chat_bot_app/auth/ui/views/ready_view.dart';
import 'package:chat_bot_app/auth/ui/views/reset_password_view.dart';
import 'package:chat_bot_app/auth/ui/views/select_gender_view.dart';
import 'package:chat_bot_app/auth/ui/views/signin_view.dart';
import 'package:chat_bot_app/auth/ui/views/signup_view.dart';
import 'package:chat_bot_app/chat/ui/views/new_conversation_view.dart';
import 'package:chat_bot_app/core/utils/check_app_routing.dart';
import 'package:chat_bot_app/main/ui/views/main_view.dart';
import 'package:chat_bot_app/onboarding/ui/views/onboarding_view.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/profile/ui/views/about_app_view.dart';
import 'package:chat_bot_app/profile/ui/views/privacy_policy_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouting {
  static final GoRouter router = GoRouter(
    initialLocation: checkAppRouting(),
    routes: <RouteBase>[
      GoRoute(
        path: Routes.onboardingView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const OnboardingView(),
          );
        },
      ),
      GoRoute(
        path: Routes.initAuthView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const InitAuthView(),
          );
        },
      ),
      GoRoute(
        path: Routes.signinView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const SigninView(),
          );
        },
      ),
      GoRoute(
        path: Routes.signupView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const SignupView(),
          );
        },
      ),
      GoRoute(
        path: Routes.resetPasswordView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const ResetPasswordView(),
          );
        },
      ),
      GoRoute(
        path: Routes.otpVerificationView,
        builder: (BuildContext context, GoRouterState state) {
          final email = state.extra as String;
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: OtpVerificationView(email: email),
          );
        },
      ),
      GoRoute(
        path: Routes.createNewPasswordView,
        builder: (BuildContext context, GoRouterState state) {
          final email = state.extra as String;
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: CreateNewPasswordView(email: email),
          );
        },
      ),
      GoRoute(
        path: Routes.selectGenderView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const SelectGenderView(),
          );
        },
      ),
      GoRoute(
        path: Routes.personalInfoView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const PersonalInfoView(),
          );
        },
      ),
      GoRoute(
        path: Routes.pinCodeView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const PinCodeView(),
          );
        },
      ),
      GoRoute(
        path: Routes.readyView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const ReadyView(),
          );
        },
      ),
      GoRoute(
        path: Routes.mainView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const MainView(),
          );
        },
      ),
      GoRoute(
        path: Routes.newConversationView,
        builder: (BuildContext context, GoRouterState state) {
          final chatId = state.extra as String;
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: NewConversationView(chatId: chatId),
          );
        },
      ),
      GoRoute(
        path: Routes.privacyPolicyView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const PrivacyPolicyView(),
          );
        },
      ),
      GoRoute(
        path: Routes.aboutAppView,
        builder: (BuildContext context, GoRouterState state) {
          return KeyedSubtree(
            key: ValueKey(context.locale.toString()),
            child: const AboutAppView(),
          );
        },
      ),
    ],
  );
}
