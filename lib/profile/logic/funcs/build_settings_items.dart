import 'package:chat_bot_app/core/constants/localization_keys.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/profile/logic/models/settings_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

List<SettingsModel> buildSettingsItems(BuildContext context) {
  return [
    SettingsModel(
      title: context.tr(LocalizationKeys.aboutGemiChatBot),
      icon: Icons.error_outline,
      onTap: () {
        context.push(Routes.aboutAppView);
      },
    ),
    SettingsModel(
      title: context.tr(LocalizationKeys.privacyPolicy),
      icon: FontAwesomeIcons.userSecret,
      onTap: () {
        context.push(Routes.privacyPolicyView);
      },
    ),
  ];
}
