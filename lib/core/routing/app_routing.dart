import 'package:chat_bot_app/onboarding/ui/views/onboarding_view.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouting {
 static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routes.onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingView();
        },
      ),
    ],
  );
}
