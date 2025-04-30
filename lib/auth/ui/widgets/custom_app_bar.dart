import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

AppBar customAppBar(BuildContext context, {String? title}) {
  return AppBar(
    title: Text(title ?? '', style: AppTextStyles.bold18),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        context.pop();
      },
      icon: const Icon(FontAwesomeIcons.arrowLeftLong, color: Colors.black),
    ),
    forceMaterialTransparency: true,
  );
}
