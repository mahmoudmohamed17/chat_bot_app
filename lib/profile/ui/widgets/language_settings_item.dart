import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LanguageSettignsItem extends StatefulWidget {
  const LanguageSettignsItem({super.key});

  @override
  State<LanguageSettignsItem> createState() => _LanguageSettignsItemState();
}

class _LanguageSettignsItemState extends State<LanguageSettignsItem> {
  bool _isOpened = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              spacing: 12,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.g_translate, color: Colors.black),
                Text(
                  AppStrings.english,
                  style: AppTextStyles.semiBold16.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isOpened = !_isOpened;
              });
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheet(
                    onClosing: () {
                      setState(() {
                        _isOpened = !_isOpened;
                      });
                    },
                    builder: (context) {
                      return const Column();
                    },
                  );
                },
              );
            },
            icon: Icon(
              _isOpened ? FontAwesomeIcons.angleUp : FontAwesomeIcons.angleDown,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
