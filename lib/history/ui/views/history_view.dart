import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/widgets/loading_dialog_body.dart';
import 'package:chat_bot_app/core/widgets/loading_overlay_widget.dart';
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
      child: BlocBuilder<TopicsCubit, TopicsState>(
        builder: (context, state) {
          return LoadingOverlayWidget(
            isLoading: state is TopicsLoading,
            dialogBody: const LoadingDialogBody(),
            child: SafeArea(
              child: Column(
                children: [
                  const HistoryViewAppBar(),
                  if (state is TopicsEmpty) ...[
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Center(child: EmptyHistoryViewWidget()),
                    ),
                    const Spacer(),
                  ],
                  if (state is TopicsSuccess)
                    Expanded(child: HistoryList(topics: state.topics)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
