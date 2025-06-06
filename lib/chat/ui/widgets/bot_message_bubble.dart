import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/extensions/context_extension.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotMessageBubble extends StatelessWidget {
  const BotMessageBubble({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: context.width * 0.65,
                child: AnimatedTextKit(
                  totalRepeatCount: 0,
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TyperAnimatedText(
                      message,
                      textAlign: TextAlign.center,
                      textStyle: AppTextStyles.regular16.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.shareNodes,
                    color: AppColors.textContainer,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: message));
                    snackBar(
                      context,
                      title: AppStrings.messageCopied,
                      timeInSeconds: 2,
                    );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.copy,
                    color: AppColors.textContainer,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
