import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/chat/logic/managers/messages_cubit/messages_cubit.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SendMessageTextBoxWidget extends StatelessWidget {
  const SendMessageTextBoxWidget({super.key, required this.chatId});
  final String chatId;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MessagesCubit>();
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 8,
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: CustomTextFormField(hintText: AppStrings.sendMessage),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              cubit.sendMessageFromUser(chatId: chatId);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: AppColors.primary,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: const CircleBorder(),
              iconColor: Colors.white,
            ),
            child: const Icon(FontAwesomeIcons.solidPaperPlane),
          ),
          ElevatedButton(
            onPressed: () {
              cubit.sendMessageFromBot(chatId: chatId);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: AppColors.itemButtonAction,
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
}
