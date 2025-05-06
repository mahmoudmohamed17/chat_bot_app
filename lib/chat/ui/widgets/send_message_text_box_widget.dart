import 'package:chat_bot_app/auth/ui/widgets/custom_text_form_field.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SendMesssageTextBoxWidget extends StatelessWidget {
  const SendMesssageTextBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 16,
        children: [
          const Expanded(child: CustomTextFormField(hintText: 'Send message')),
          Container(
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              FontAwesomeIcons.solidPaperPlane,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
