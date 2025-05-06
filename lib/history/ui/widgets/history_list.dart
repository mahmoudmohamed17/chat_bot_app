import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/history/ui/widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 10,
      itemBuilder: (_, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (direction) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        elevation: 5,
                        insetAnimationDuration: const Duration(
                          milliseconds: 500,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 16,
                            children: [
                              const Text(
                                AppStrings.goodJob,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bold20,
                              ),
                              Text(
                                AppStrings.timeToSetSomeUserPrefs,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.regular16.copyWith(
                                  color: AppColors.textContainer,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      label: 'Ok',
                                      backgroundColor: AppColors.primary,
                                      labelColor: Colors.white,
                                      onPressed: () {
                                        context.pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.itemButtonAction,
                icon: FontAwesomeIcons.solidTrashCan,
              ),
              SlidableAction(
                onPressed: (direction) {},
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.primary,
                icon: FontAwesomeIcons.shareNodes,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: HistoryItem(index: index),
          ),
        );
      },
    );
  }
}
