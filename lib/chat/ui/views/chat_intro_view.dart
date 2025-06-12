import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/assets.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatIntroView extends StatelessWidget {
  const ChatIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<ChatsCubit>(),
      child: BlocConsumer<ChatsCubit, ChatsState>(
        listener: (context, state) {
          if (state is ChatsSuccess) {
            final chatId = context.read<ChatsCubit>().currentChatId;
            context.push(Routes.newConversationView, extra: chatId);
          }
          if (state is ChatsFailed) {
            snackBar(context, title: state.errorMsg);
          }
        },
        builder: (context, state) {
          final chatCubit = context.read<ChatsCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                const SizedBox(height: 48),
                const Spacer(),
                Image.asset(Assets.imagesAppLogo, scale: 3),
                const Text(
                  AppStrings.appName,
                  style: AppTextStyles.bold24,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  AppStrings.startChatHint,
                  style: AppTextStyles.regular18,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    label: AppStrings.startChat,
                    backgroundColor: AppColors.primary,
                    labelColor: Colors.white,
                    onPressed: () async {
                      await chatCubit.createChat();
                    },
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          );
        },
      ),
    );
  }
}
