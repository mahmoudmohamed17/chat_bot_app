import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/build_border.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.onFieldSubmitted,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.controller,
  });
  final String hintText;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final TextInputType? textInputType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCubit, bool>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          style: AppTextStyles.regular16,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          validator: (value) {
            if (value!.isEmpty) {
              return '$hintText is required';
            } else {
              return null;
            }
          },
          textInputAction: TextInputAction.send,
          minLines: 1,
          maxLines: 10,
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.regular16.copyWith(
              color: state ? null : AppColors.textContainer,
            ),
            fillColor: AppColors.container,
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
