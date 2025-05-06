import 'package:chat_bot_app/core/extensions/context_extension.dart';
import 'package:chat_bot_app/history/ui/widgets/empty_history_view_widget.dart';
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
          Column(
            children: [
              SizedBox(
                height: context.height * 0.20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: EmptyHistoryViewWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

