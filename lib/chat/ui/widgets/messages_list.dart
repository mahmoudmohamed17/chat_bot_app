import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:chat_bot_app/chat/logic/managers/messages_cubit/messages_cubit.dart';
import 'package:chat_bot_app/chat/ui/widgets/bot_message_bubble.dart';
import 'package:chat_bot_app/chat/ui/widgets/custom_loading_comment.dart';
import 'package:chat_bot_app/chat/ui/widgets/user_message_bubble.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/constants/dummy.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key, required this.chatId});
  final String chatId;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        try {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        } catch (e) {
          log('Error scrolling to bottom: $e');
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getIt.get<SupabaseDatabaseService>().messagesStream(
        widget.chatId,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          snackBar(context, title: AppStrings.fetchingMessagesErrorAlert);
          return Align(
            child: FadeIn(
              child: Image.asset(Assets.imagesAppLogoGrey, scale: 3),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final comments = snapshot.data as List<Map<String, dynamic>>?;
        if (comments == null || comments.isEmpty) {
          return Align(
            child: FadeIn(
              child: Image.asset(Assets.imagesAppLogoGrey, scale: 3),
            ),
          );
        }

        return BlocBuilder<MessagesCubit, MessagesState>(
          builder: (context, state) {
            _scrollToBottom();
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              controller: _scrollController,
              itemCount: comments.length + (state is MessagesLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (state is MessagesLoading && index == comments.length) {
                  return const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CustomLoadingComment(),
                    ),
                  );
                }
                final comment = comments[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child:
                      comment['sender'] == AppStrings.user
                          ? UserMessageBubble(
                            message: comment['message'] ?? dummyUserMessage,
                          )
                          : BotMessageBubble(
                            message: comment['message'] ?? dummyBotMessage,
                          ),
                );
              },
            );
          },
        );
      },
    );
  }
}
