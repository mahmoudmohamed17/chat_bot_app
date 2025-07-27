import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/history/logic/models/topic_model.dart';
import 'package:chat_bot_app/history/ui/widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<TopicModel> topics;

  CustomSearchDelegate({required this.topics});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(FontAwesomeIcons.solidCircleXmark),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (topics.isEmpty) {
      return const Center(
        child: Column(
          children: [
            Spacer(),
            Text(
              'No Topics Added Yet!',
              textAlign: TextAlign.center,
              style: AppTextStyles.bold20,
            ),
            Spacer(),
          ],
        ),
      );
    }
    final results =
        topics
            .where(
              (topic) =>
                  topic.title!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    if (results.isEmpty) {
      return const Center(
        child: Column(
          children: [
            Spacer(),
            Text(
              'No Matching Results!',
              textAlign: TextAlign.center,
              style: AppTextStyles.bold20,
            ),
            Spacer(),
          ],
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      children:
          topics
              .map(
                (topis) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: HistoryItem(model: topis),
                ),
              )
              .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Spacer(),
          Text(
            'Start searching by typing what you want!',
            textAlign: TextAlign.center,
            style: AppTextStyles.bold20,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
