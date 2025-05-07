 import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/profile/logic/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<SettingsModel> buildSettingsItems(BuildContext context) {
    return [
      SettingsModel(
        title: AppStrings.aboutGemiChatBot,
        icon: Icons.error_outline,
        onTap: () {},
      ),
      SettingsModel(
        title: AppStrings.privacyPolicy,
        icon: FontAwesomeIcons.userSecret,
        onTap: () {},
      ),
      SettingsModel(
        title: AppStrings.logout,
        icon: FontAwesomeIcons.rightFromBracket,
        onTap: () {},
      ),
    ];
  }