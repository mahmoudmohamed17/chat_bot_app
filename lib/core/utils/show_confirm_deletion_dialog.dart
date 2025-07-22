import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/core/widgets/custom_dialog_badge.dart';
import 'package:chat_bot_app/history/logic/models/topic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

Future<dynamic> showConfirmDeletionDialog(
  BuildContext context, {
  TopicModel? topic,
  bool? isDeletingAll,
}) {
  final newTopic = topic;
  return showDialog(
    context: context,
    builder: (cxt) {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt.get<TopicsCubit>()),
          BlocProvider.value(value: getIt.get<ChatsCubit>()),
        ],
        child: BlocConsumer<TopicsCubit, TopicsState>(
          listener: (context, state) {
            if (state is TopicsSuccess || state is TopicsEmpty) {
              context.pop();
            }
            if (state is TopicsFailed) {
              snackBar(context, title: state.errorMsg);
            }
          },
          builder: (context, state) {
            final topicsCubit = context.read<TopicsCubit>();
            final chatsCubit = context.read<ChatsCubit>();
            return ModalProgressHUD(
              inAsyncCall: state is TopicsLoading,
              child: Dialog(
                backgroundColor: Colors.white,
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 16,
                    children: [
                      const CustomDialogBadge(
                        icon: FontAwesomeIcons.circleQuestion,
                      ),
                      const Text(
                        AppStrings.areYouSureToDelete,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bold16,
                      ),
                      Text(
                        AppStrings.areYouSureToDeleteHint,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBold14.copyWith(
                          color: AppColors.textContainer,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 8,
                        children: [
                          Expanded(
                            child: CustomButton(
                              label: AppStrings.close,
                              backgroundColor: Colors.white,
                              labelColor: Colors.black,
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomButton(
                              label: AppStrings.delete,
                              backgroundColor: AppColors.primary,
                              labelColor: Colors.white,
                              onPressed: () async {
                                if (isDeletingAll != null && isDeletingAll) {
                                  await topicsCubit.deleteAllTopics();
                                  await topicsCubit.deleteAllTopicsData(
                                    deleteAllChats: chatsCubit.deleteAllChats,
                                    deleteAllMessages:
                                        chatsCubit.deleteAllMessages,
                                  );
                                }
                                if (topic != null) {
                                  await topicsCubit.deleteTopic(
                                    topic: newTopic!,
                                  );
                                  await topicsCubit.deleteTopicData(
                                    topic: newTopic,
                                    deleteChat: chatsCubit.deleteChat,
                                    deleteMessages:
                                        chatsCubit.deleteChatMessages,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
