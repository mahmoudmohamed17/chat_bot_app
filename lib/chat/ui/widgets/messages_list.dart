
import 'package:chat_bot_app/chat/ui/widgets/bot_message_bubble.dart';
import 'package:chat_bot_app/chat/ui/widgets/user_message_bubble.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        UserMessageBubble(),
        SizedBox(height: 10),
        BotMessageBubble(),
        SizedBox(height: 10),
        UserMessageBubble(),
        SizedBox(height: 10),
        BotMessageBubble(),
        SizedBox(height: 10),
        UserMessageBubble(),
        SizedBox(height: 10),
        BotMessageBubble(),
      ],
    );
  }
}
