import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/chat/logic/managers/messages_cubit/messages_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
import 'package:chat_bot_app/chat/ui/widgets/messages_list.dart';
import 'package:chat_bot_app/chat/ui/widgets/send_message_text_box_widget.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewConversationView extends StatelessWidget {
  const NewConversationView({super.key, required this.chatId});
  final String chatId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt.get<MessagesCubit>()),
        BlocProvider.value(value: getIt.get<TopicsCubit>()),
      ],
      child: Scaffold(
        appBar: customAppBar(context, title: AppStrings.appName),
        body: Column(
          children: [
            Expanded(child: MessagesList(chatId: chatId)),
            SendMessageTextBoxWidget(chatId: chatId),
          ],
        ),
      ),
    );
  }
}
