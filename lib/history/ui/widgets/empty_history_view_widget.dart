import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/core/constants/localization_keys.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/history/ui/widgets/changing_empty_topics_picture.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmptyHistoryViewWidget extends StatelessWidget {
  const EmptyHistoryViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatsCubit, ChatsState>(
      listener: (context, state) {
        if (state is ChatsSuccess) {
          context.push(
            Routes.newConversationView,
            extra: context.read<ChatsCubit>().currentChatId,
          );
        }
        if (state is ChatsFailed) {
          snackBar(context, title: state.errorMsg);
        }
      },
      builder: (context, state) {
        final chatCubit = context.read<ChatsCubit>();
        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            const ChangingEmptyTopicsPicture(),
            Text(
              context.tr(LocalizationKeys.historyIsEmpty),
              style: AppTextStyles.bold18,
              textAlign: TextAlign.center,
            ),
            Text(
              context.tr(LocalizationKeys.historyIsEmptyHint),
              style: AppTextStyles.regular16,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: context.tr(LocalizationKeys.startChat),
                backgroundColor: AppColors.primary,
                labelColor: Colors.white,
                onPressed: () async {
                  await chatCubit.createChat();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
