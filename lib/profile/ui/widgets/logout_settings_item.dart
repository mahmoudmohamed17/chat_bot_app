import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/profile/logic/funcs/signout_confirm_dialog.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogoutSettingsItem extends StatelessWidget {
  const LogoutSettingsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await signoutConfirmDialog(context);
      },
      child: BlocBuilder<ModeCubit, bool>(
        builder: (context, state) {
          final cubit = context.read<ModeCubit>();
          return Container(
            decoration: BoxDecoration(
              color:
                  cubit.state
                      ? AppColors.darkModeGeneralColor
                      : AppColors.container,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              spacing: 12,
              children: [
                Icon(
                  FontAwesomeIcons.rightFromBracket,
                  color: cubit.state ? null : Colors.red,
                ),
                Text(
                  AppStrings.logout,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: cubit.state ? null : Colors.red,
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
