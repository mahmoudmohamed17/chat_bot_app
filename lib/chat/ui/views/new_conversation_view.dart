import 'package:chat_bot_app/auth/ui/widgets/custom_app_bar.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
import 'package:chat_bot_app/chat/ui/widgets/messages_list.dart';
import 'package:chat_bot_app/chat/ui/widgets/send_message_text_box_widget.dart';
import 'package:chat_bot_app/core/constants/localization_keys.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NewConversationView extends StatelessWidget {
  const NewConversationView({super.key, required this.chatId});
  final String chatId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMessageCubitForChat(chatId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: customAppBar(
              context,
              title: context.tr(LocalizationKeys.appName),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: customAppBar(
              context,
              title: context.tr(LocalizationKeys.appName),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Error loading chat please try again.',
                    style: AppTextStyles.regular18,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Go Back',
                      style: AppTextStyles.regular14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: customAppBar(
              context,
              title: context.tr(LocalizationKeys.appName),
            ),
            body: const Center(child: Text('No data available')),
          );
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: snapshot.data!..initializeForChat(chatId),
            ),
            BlocProvider.value(value: getIt.get<TopicsCubit>()),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                context.tr(LocalizationKeys.appName),
                style: AppTextStyles.bold18,
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  snapshot.data!.reset();
                  context.go(Routes.mainView);
                },
                icon: const Icon(FontAwesomeIcons.arrowLeftLong),
              ),
              forceMaterialTransparency: true,
            ),
            body: Column(
              children: [
                Expanded(child: MessagesList(chatId: chatId)),
                SendMessageTextBoxWidget(chatId: chatId),
              ],
            ),
          ),
        );
      },
    );
  }
}
