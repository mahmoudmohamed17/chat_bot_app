import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/history/ui/widgets/empty_history_view_widget.dart';
import 'package:chat_bot_app/history/ui/widgets/history_list.dart';
import 'package:chat_bot_app/history/ui/widgets/history_view_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt.get<ChatsCubit>()),
        BlocProvider.value(value: getIt.get<TopicsCubit>()),
      ],
      child: BlocBuilder<TopicsCubit, TopicsState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                const HistoryViewAppBar(),
                if (state is TopicsEmpty) ...[
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Center(child: EmptyHistoryViewWidget()),
                  ),
                  const Spacer(flex: 2),
                ],
                if (state is TopicsSuccess)
                  Expanded(child: HistoryList(topics: state.topics)),
              ],
            ),
          );
        },
      ),
    );
  }
}
