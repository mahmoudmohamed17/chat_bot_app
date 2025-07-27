import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:chat_bot_app/chat/logic/managers/messages_cubit/messages_cubit.dart';
import 'package:chat_bot_app/chat/ui/widgets/bot_message_bubble.dart';
import 'package:chat_bot_app/chat/ui/widgets/custom_error_comment_icon.dart';
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
  int _previousMessageCount = 0;
  bool _shouldAutoScroll = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollChanged);
  }

  void _onScrollChanged() {
    // Disable auto-scroll if user manually scrolls up
    if (_scrollController.hasClients) {
      final isAtBottom =
          _scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100;
      if (_shouldAutoScroll != isAtBottom) {
        setState(() {
          _shouldAutoScroll = isAtBottom;
        });
      }
    }
  }

  void _scrollToBottom({bool force = false}) {
    if (!_shouldAutoScroll && !force) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        try {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          );
        } catch (e) {
          log('Error scrolling to bottom: $e');
        }
      }
    });
  }

  Widget _buildEmptyState() {
    return Align(
      child: FadeIn(child: Image.asset(Assets.imagesAppLogoGrey, scale: 3)),
    );
  }

  Widget _buildErrorState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CustomErrorCommentIcon()],
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> message, int index) {
    final isUser = message['sender'] == AppStrings.user;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child:
          isUser
              ? UserMessageBubble(
                message: message['message'] ?? dummyUserMessage,
              )
              : BotMessageBubble(
                message: message['message'] ?? dummyBotMessage,
              ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollChanged);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessagesCubit, MessagesState>(
      listener: (context, state) {
        if (state is MessagesFailed) {
          snackBar(context, title: AppStrings.fetchingMessagesErrorAlert);
        }
      },
      builder: (context, state) {
        return StreamBuilder(
          stream: getIt.get<SupabaseDatabaseService>().messagesStream(
            widget.chatId,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              log('Stream error: ${snapshot.error}');
              return _buildErrorState();
            }

            final messages = snapshot.data ?? [];

            if (messages.isEmpty && state is! MessagesLoading) {
              return _buildEmptyState();
            }

            if (messages.length > _previousMessageCount) {
              _scrollToBottom();
              _previousMessageCount = messages.length;
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              controller: _scrollController,
              itemCount: messages.length + (state is MessagesLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (state is MessagesLoading && index == messages.length) {
                  return const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CustomLoadingComment(),
                    ),
                  );
                }

                if (index < messages.length) {
                  return _buildMessageItem(messages[index], index);
                }

                return const SizedBox.shrink();
              },
            );
          },
        );
      },
    );
  }
}
