import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/profile/logic/funcs/signout_confirm_dialog.dart';
import 'package:chat_bot_app/profile/logic/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

List<SettingsModel> buildSettingsItems(BuildContext context) {
  return [
    SettingsModel(
      title: AppStrings.aboutGemiChatBot,
      icon: Icons.error_outline,
      onTap: () {
        context.push(Routes.aboutAppView);
      },
    ),
    SettingsModel(
      title: AppStrings.privacyPolicy,
      icon: FontAwesomeIcons.userSecret,
      onTap: () {
        context.push(Routes.privacyPolicyView);
      },
    ),
    SettingsModel(
      title: AppStrings.logout,
      icon: FontAwesomeIcons.rightFromBracket,
      onTap: () {
        signoutConfirmDialog(context);
      },
    ),
  ];
}
