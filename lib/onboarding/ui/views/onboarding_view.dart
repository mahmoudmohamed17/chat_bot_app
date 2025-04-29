import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/onboarding/ui/widgets/onboarding_third_body.dart';
import 'package:chat_bot_app/onboarding/ui/widgets/onboarding_first_body.dart';
import 'package:chat_bot_app/onboarding/ui/widgets/onboarding_second_body.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        activeIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: const [
                OnboardingFirstBody(),
                OnboardingSecondBody(),
                OnboardingThirdBody(),
              ],
            ),
          ),
          DotsIndicator(
            dotsCount: 3,
            position: activeIndex.toDouble(),
            animate: true,
            decorator: DotsDecorator(
              color: Colors.grey[300]!,
              activeColor: AppColors.primary,
              size: const Size(24, 9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              spacing: const EdgeInsets.symmetric(horizontal: 3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 16,
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Skip',
                    onPressed: () {
                      context.go(Routes.initAuthView);
                      SharedPrefs.setBool(isOnboardingSeen, true);
                    },
                    backgroundColor: Colors.white,
                    labelColor: Colors.black,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    label: 'Next',
                    onPressed: () {
                      if (activeIndex == 2) {
                        context.go(Routes.initAuthView);
                        SharedPrefs.setBool(isOnboardingSeen, true);
                      } else {
                        _pageController.animateToPage(
                          activeIndex + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    backgroundColor: AppColors.primary,
                    labelColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
