import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/utils/show_confirm_deletion_dialog.dart';
import 'package:chat_bot_app/history/logic/models/topic_model.dart';
import 'package:chat_bot_app/history/ui/widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key, required this.topics});
  final List<TopicModel> topics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: topics.length,
      itemBuilder: (context_, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (direction) {
                  showConfirmDeletionDialog(context, topic: topics[index]);
                },
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.itemButtonAction,
                icon: FontAwesomeIcons.solidTrashCan,
              ),
              SlidableAction(
                onPressed: (direction) {},
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.primary,
                icon: FontAwesomeIcons.shareNodes,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: HistoryItem(model: topics[index]),
          ),
        );
      },
    );
  }
}
