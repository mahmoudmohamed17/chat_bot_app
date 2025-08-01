import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:chat_bot_app/profile/logic/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.model});
  final SettingsModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.onTap,
      child: BlocBuilder<ModeCubit, bool>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color:
                  context.read<ModeCubit>().state
                      ? AppColors.darkModeGeneralColor
                      : AppColors.container,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              spacing: 12,
              children: [
                Icon(
                  model.icon,
                  color:
                      SharedPrefs.getBool(isDarkMode)
                          ? Colors.white
                          : Colors.black,
                ),
                Text(
                  model.title,
                  style: AppTextStyles.semiBold16.copyWith(
                    color:
                        SharedPrefs.getBool(isDarkMode)
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
