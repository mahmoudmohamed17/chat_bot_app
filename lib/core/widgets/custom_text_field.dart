import 'package:chat_bot_app/auth/ui/widgets/custom_password_form_field.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.onSubmitted,
    required this.controller,
  });
  final String hintText;
  final void Function(String)? onSubmitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCubit, bool>(
      builder: (context, state) {
        return TextField(
          controller: controller,
          style: AppTextStyles.regular16,
          onSubmitted: onSubmitted,
          textInputAction: TextInputAction.send,
          maxLines: null,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.regular16,
            fillColor:
                context.read<ModeCubit>().state
                    ? AppColors.darkModeSecondaryColor
                    : AppColors.container,
            contentPadding: const EdgeInsets.all(16),
            filled: true,
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
          ),
        );
      },
    );
  }
}
