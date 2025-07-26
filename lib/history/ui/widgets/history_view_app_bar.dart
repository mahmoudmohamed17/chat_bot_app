import 'dart:developer';

import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/show_confirm_deletion_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistoryViewAppBar extends StatelessWidget {
  const HistoryViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 40),
          child: Image.asset(Assets.imagesAppLogo, scale: 10.5),
        ),
        const Text(AppStrings.history, style: AppTextStyles.bold18),
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  log('Chat id: ${context.read<ChatsCubit>().currentChatId}');
                },
                icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 18),
              ),
              IconButton(
                onPressed: () {
                  showConfirmDeletionDialog(context, isDeletingAll: true);
                },
                icon: const Icon(FontAwesomeIcons.trashCan, size: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
