import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/localization_keys.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/core/widgets/custom_button.dart';
import 'package:chat_bot_app/profile/ui/widgets/select_language_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LanguageSelectionDialog extends StatefulWidget {
  const LanguageSelectionDialog({super.key, this.onClose, this.langSelected});
  final void Function(bool)? onClose;
  final void Function(String)? langSelected;

  @override
  State<LanguageSelectionDialog> createState() =>
      _LanguageSelectionDialogState();
}

final List<String> translations = [AppStrings.english, AppStrings.arabic];

class _LanguageSelectionDialogState extends State<LanguageSelectionDialog> {
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
            children: List.generate(translations.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _activeIndex = index;
                  });
                },
                child: SelectLanguageItem(
                  text: translations[index],
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
                  label: context.tr(LocalizationKeys.close),
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
                  label: context.tr(LocalizationKeys.save),
                  backgroundColor:
                      _activeIndex == SharedPrefs.getInt(selectedLangIndex)
                          ? AppColors.primaryExtraLight
                          : AppColors.primary,
                  labelColor: Colors.white,
                  onPressed: () {
                    SharedPrefs.setInt(selectedLangIndex, _activeIndex);
                    widget.onClose?.call(true);
                    final local = translations[_activeIndex];
                    if (local == AppStrings.english) {
                      widget.langSelected?.call(LocalizationKeys.english);
                      context.setLocale(const Locale(LocalizationKeys.en));
                    } else {
                      widget.langSelected?.call(LocalizationKeys.arabic);
                      context.setLocale(const Locale(LocalizationKeys.ar));
                    }
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
