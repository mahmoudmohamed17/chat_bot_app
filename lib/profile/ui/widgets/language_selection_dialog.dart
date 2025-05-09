import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/profile/ui/widgets/select_language_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LanguageSelectionDialog extends StatefulWidget {
  const LanguageSelectionDialog({super.key, this.onClose});
  final void Function(bool)? onClose;


  @override
  State<LanguageSelectionDialog> createState() =>
      _LanguageSelectionDialogState();
}

class _LanguageSelectionDialogState extends State<LanguageSelectionDialog> {
  final List<String> _translations = [AppStrings.english, AppStrings.arabic];
  int _activeIndex = SharedPrefs.getInt(selectedLangIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            spacing: 16,
            children: List.generate(_translations.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _activeIndex = index;
                  });
                },
                child: SelectLanguageItem(
                  text: _translations[index],
                  isActive: _activeIndex == index,
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16,
            children: [
              Expanded(
                child: CustomButton(
                  label: AppStrings.close,
                  backgroundColor: Colors.white,
                  labelColor: Colors.black,
                  onPressed: () {
                    widget.onClose?.call(true);
                    context.pop();
                  },
                ),
              ),
              Expanded(
                child: CustomButton(
                  label: AppStrings.save,
                  backgroundColor:
                      _activeIndex == SharedPrefs.getInt(selectedLangIndex)
                          ? AppColors.primaryExtraLight
                          : AppColors.primary,
                  labelColor: Colors.white,
                  onPressed: () {
                    SharedPrefs.setInt(selectedLangIndex, _activeIndex);
                    SharedPrefs.setString(selectedLangLabel, _translations[_activeIndex]);
                    widget.onClose?.call(true);
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
