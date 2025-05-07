import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/profile/logic/managers/cubit/mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModeSettignsItem extends StatelessWidget {
  const ModeSettignsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCubit, bool>(
      builder: (context, state) {
        var cubit = context.read<ModeCubit>();
        return Container(
          decoration: BoxDecoration(
            color: AppColors.container,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(FontAwesomeIcons.eye, color: Colors.black),
                    Text(
                      cubit.state ? AppStrings.darkMode : AppStrings.lightMode,
                      style: AppTextStyles.semiBold16.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: cubit.state,
                onChanged: (value) {
                  cubit.toggleMode(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
