import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/profile/ui/widgets/language_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LanguageSettignsItem extends StatefulWidget {
  const LanguageSettignsItem({super.key});

  @override
  State<LanguageSettignsItem> createState() => _LanguageSettignsItemState();
}

class _LanguageSettignsItemState extends State<LanguageSettignsItem> {
  bool _isDialogOpen = false;

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
                  SharedPrefs.getString(selectedLangLabel),
                  style: AppTextStyles.semiBold16.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isDialogOpen = true;
              });
              showModalBottomSheet(
                context: context,
                isDismissible: false,
                builder: (context) {
                  return LanguageSelectionDialog(
                    onClose: (value) {
                      if (value) {
                        setState(() {
                          _isDialogOpen = false;
                        });
                      }
                    },
                  );
                },
              );
            },
            icon: Icon(
              _isDialogOpen
                  ? FontAwesomeIcons.angleUp
                  : FontAwesomeIcons.angleDown,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
