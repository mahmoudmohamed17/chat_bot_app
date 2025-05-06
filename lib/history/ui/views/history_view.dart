import 'package:chat_bot_app/history/ui/widgets/history_list.dart';
import 'package:chat_bot_app/history/ui/widgets/history_view_app_bar.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const HistoryViewAppBar(),
          Expanded(
            child: HistoryList(),
          ),
        ],
      ),
    );
  }
}
