import 'package:chat_bot_app/core/constants/dummy.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/history/logic/models/topic_model.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.model});
  final TopicModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCubit, bool>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color:
                context.read<ModeCubit>().state
                    ? AppColors.darkModeGeneralColor
                    : AppColors.container,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            horizontalTitleGap: 32,
            onTap: () {
              getMessageCubitForChat(model.forChat!);
              context.push(Routes.newConversationView, extra: model.forChat!);
            },
            title: Text(
              model.title ?? dummyTopicTitle,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.semiBold14,
            ),
            subtitle: Text(
              model.createdAt ?? dummyTopicDate,
              style: AppTextStyles.medium12.copyWith(
                color:
                    context.read<ModeCubit>().state
                        ? Colors.white70
                        : AppColors.textContainer,
              ),
            ),
            trailing: const Icon(FontAwesomeIcons.chevronRight, size: 18),
          ),
        );
      },
    );
  }
}
