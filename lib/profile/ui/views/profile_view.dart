import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/profile/logic/funcs/build_settings_items.dart';
import 'package:chat_bot_app/profile/ui/widgets/language_settings_item.dart';
import 'package:chat_bot_app/profile/ui/widgets/logout_settings_item.dart';
import 'package:chat_bot_app/profile/ui/widgets/mode_setting_item.dart';
import 'package:chat_bot_app/profile/ui/widgets/profile_view_app_bar.dart';
import 'package:chat_bot_app/profile/ui/widgets/settings_item.dart';
import 'package:chat_bot_app/profile/ui/widgets/user_profile_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = buildSettingsItems(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt.get<AuthCubit>()),
        BlocProvider.value(value: getIt.get<UsersCubit>()),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SafeArea(child: ProfileViewAppBar()),
              const SizedBox(height: 16),
              const UserProfileBadge(),
              const SizedBox(height: 32),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LanguageSettignsItem(),
                  const SizedBox(height: 12),
                  const ModeSettignsItem(),
                  const SizedBox(height: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(settings.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SettingsItem(model: settings[index]),
                      );
                    }),
                  ),
                  const LogoutSettingsItem(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
