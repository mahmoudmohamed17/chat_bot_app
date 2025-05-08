import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/chat/ui/widgets/messages_list.dart';
import 'package:chat_bot_app/chat/ui/widgets/send_message_text_box_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class NewConversationView extends StatelessWidget {
  const NewConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: AppStrings.appName),
      body: const Column(
        children: [
          /// TODO: Use cubit to manage the state of showing messages with the app logo
          /// Align(child: Image.asset(Assets.imagesAppLogoGrey, scale: 3)),
          Expanded(child: MessagesList()),
          SendMessageTextBoxWidget(),
        ],
      ),
    );
  }
}
