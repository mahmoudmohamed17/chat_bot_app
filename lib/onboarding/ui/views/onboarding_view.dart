import 'package:chat_bot_app/onboarding/ui/widgets/onboarding_first_body.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingFirstBody(),
    );
  }
}