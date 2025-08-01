import 'package:chat_bot_app/core/constants/localization_keys.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:chat_bot_app/profile/ui/widgets/language_selection_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LanguageSettignsItem extends StatefulWidget {
  const LanguageSettignsItem({super.key});

  @override
  State<LanguageSettignsItem> createState() => _LanguageSettignsItemState();
}

class _LanguageSettignsItemState extends State<LanguageSettignsItem> {
  bool _isDialogOpen = false;
  String _langSelected = LocalizationKeys.english;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCubit, bool>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color:
                context.read<ModeCubit>().state
                    ? AppColors.darkModeGeneralColor
                    : AppColors.container,
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
                    const Icon(Icons.g_translate),
                    Text(
                      context.tr(_langSelected),
                      style: AppTextStyles.semiBold16.copyWith(),
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
                    builder: (context) {
                      return LanguageSelectionDialog(
                        onClose: (value) {
                          if (value) {
                            setState(() {
                              _isDialogOpen = false;
                            });
                          }
                        },
                        langSelected: (value) {
                          _langSelected = value;
                        },
                      );
                    },
                  );
                },
                icon: Icon(
                  _isDialogOpen
                      ? FontAwesomeIcons.angleUp
                      : FontAwesomeIcons.angleDown,
                  size: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
