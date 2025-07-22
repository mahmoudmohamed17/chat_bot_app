import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/core/widgets/custom_dialog_badge.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return ConfettiWidget(
      confettiController: confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      maxBlastForce: 15,
      emissionFrequency: 0.6,
      numberOfParticles: 15,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  const CustomDialogBadge(icon: Icons.check),
                  Text(
                    context.tr(AppStrings.youAreReady),
                    style: AppTextStyles.bold28,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    context.tr(AppStrings.youAreReadyHint),
                    style: AppTextStyles.regular18,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: AppStrings.goBackSignin,
                  backgroundColor: AppColors.primary,
                  labelColor: Colors.white,
                  onPressed: () {
                    context.go(Routes.signinView);
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
