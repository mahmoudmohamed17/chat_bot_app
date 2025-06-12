import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class EmptyHistoryViewWidget extends StatelessWidget {
  const EmptyHistoryViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt.get<ChatsCubit>()),
        BlocProvider.value(value: getIt.get<TopicsCubit>()),
      ],
      child: BlocConsumer<ChatsCubit, ChatsState>(
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
              SvgPicture.asset(
                Assets.imagesEmptyFolder,
                height: 150,
                width: 150,
              ),
              const Text(
                AppStrings.historyIsEmpty,
                style: AppTextStyles.bold18,
                textAlign: TextAlign.center,
              ),
              const Text(
                AppStrings.historyIsEmptyHint,
                style: AppTextStyles.regular16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: 'Start chat',
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
      ),
    );
  }
}
