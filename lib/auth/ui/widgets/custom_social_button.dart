import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.labelColor,
    required this.image,
  });
  final String label;
  final String image;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCubit, bool>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                context.read<ModeCubit>().state
                    ? AppColors.darkModeGeneralColor
                    : Colors.white,
            elevation: 1,
            padding: const EdgeInsets.all(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Image.asset(image, height: 24, width: 24),
              Text(
                label,
                style: AppTextStyles.medium16.copyWith(
                  color: context.read<ModeCubit>().state ? null : labelColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
