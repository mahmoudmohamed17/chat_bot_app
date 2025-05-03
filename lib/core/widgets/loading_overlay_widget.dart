import 'dart:ui';
import 'package:chat_bot_app/auth/ui/widgets/checkout_icon_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/get_color_opacity.dart';
import 'package:flutter/material.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlayWidget({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child, // Main screen
        if (isLoading)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: getColorOpacity(Colors.black, 0.3),
                alignment: Alignment.center,
                child: _buildDialogBox(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDialogBox() {
    return Material(
      borderOnForeground: false,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CheckoutIconWidget(),
            const SizedBox(height: 12),
            const Text(AppStrings.hadVeryLittle, style: AppTextStyles.bold18),
            const SizedBox(height: 8),
            Text(
              AppStrings.redirectToHomePageMessage,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular14.copyWith(color: AppColors.textContainer),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
