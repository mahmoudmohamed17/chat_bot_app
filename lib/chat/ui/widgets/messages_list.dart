import 'package:animate_do/animate_do.dart';
import 'package:chat_bot_app/chat/ui/widgets/bot_message_bubble.dart';
import 'package:chat_bot_app/chat/ui/widgets/user_message_bubble.dart';
import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key, required this.chatId});
  final String chatId;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutBack,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: SupabaseDatabaseService().messagesStream(
        'd6b09b9b-c63f-426f-bb03-cb4c70d55f74',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error occured');
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

        WidgetsBinding.instance.addPostFrameCallback((v) => _scrollToBottom());

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          controller: _scrollController,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child:
                  comment['sender'] == AppStrings.user
                      ? const UserMessageBubble(message: userMessage)
                      : const BotMessageBubble(message: botMessage),
            );
          },
        );
      },
    );
  }
}
