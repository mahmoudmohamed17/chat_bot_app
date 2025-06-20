import 'package:chat_bot_app/core/constants/dummy.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/history/logic/models/topic_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.model});
  final TopicModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        horizontalTitleGap: 32,
        title: Text(
          model.title ?? dummyTopicTitle,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.semiBold14.copyWith(color: Colors.black),
        ),
        subtitle: Text(
          model.createdAt ?? dummyTopicDate,
          style: AppTextStyles.medium12.copyWith(
            color: AppColors.textContainer,
          ),
        ),
        trailing: const Icon(
          FontAwesomeIcons.chevronRight,
          color: Colors.black,
          size: 18,
        ),
        // dense: true,
      ),
    );
  }
}
