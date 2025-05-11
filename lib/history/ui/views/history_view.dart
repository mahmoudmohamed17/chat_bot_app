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
        BlocProvider(create: (context) => getIt.get<ChatsCubit>()),
        BlocProvider(create: (context) => getIt.get<TopicsCubit>()),
      ],
      child: SafeArea(
        child: Column(
          children: [
            const HistoryViewAppBar(),
            BlocBuilder<TopicsCubit, TopicsState>(
              builder: (context, state) {
                if (state is TopicsSuccess) {
                  return Expanded(child: HistoryList(topics: state.topics));
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Center(child: EmptyHistoryViewWidget()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
