import 'package:chat_bot_app/auth/ui/widgets/checkout_icon_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ReadyView extends StatefulWidget {
  const ReadyView({super.key});

  @override
  State<ReadyView> createState() => _ReadyViewState();
}

class _ReadyViewState extends State<ReadyView> {
  ConfettiController confettiController = ConfettiController(
    duration: const Duration(seconds: 10),
  )..play();
  bool _isLoading = false;
  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: confettiController,
      shouldLoop: true,
      blastDirectionality: BlastDirectionality.explosive,
      maxBlastForce: 30,
      minBlastForce: 10,
      emissionFrequency: 0.2,
      numberOfParticles: 20,
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
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
                    CheckoutIconWidget(),
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
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
