import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/chat/logic/managers/messages_cubit/messages_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SendMessageTextBoxWidget extends StatefulWidget {
  const SendMessageTextBoxWidget({super.key, required this.chatId});
  final String chatId;

  @override
  State<SendMessageTextBoxWidget> createState() =>
      _SendMessageTextBoxWidgetState();
}

class _SendMessageTextBoxWidgetState extends State<SendMessageTextBoxWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagesCubit = context.read<MessagesCubit>();
    final topicsCubit = context.read<TopicsCubit>();
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 8,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: CustomTextFormField(
                hintText: AppStrings.sendMessage,
                controller: controller,
                onFieldSubmitted: (value) async {
                  await execute(messagesCubit, topicsCubit);
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await execute(messagesCubit, topicsCubit);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor:
                  controller.text.isEmpty
                      ? AppColors.primaryExtraLight
                      : AppColors.primary,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: const CircleBorder(),
              iconColor: Colors.white,
            ),
            child: const Icon(FontAwesomeIcons.solidPaperPlane),
          ),
        ],
      ),
    );
  }

  Future<void> execute(
    MessagesCubit messagesCubit,
    TopicsCubit topicsCubit,
  ) async {
    await messagesCubit.sendMessage(
      chatId: widget.chatId,
      message: controller.text,
    );
    controller.clear();
    await messagesCubit.getBotResponse(createTopic: topicsCubit.createTopic);
  }
}
