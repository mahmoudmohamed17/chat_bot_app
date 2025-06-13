import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
import 'package:chat_bot_app/chat/ui/views/chat_intro_view.dart';
import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/constants/localization_keys.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/core/utils/snack_bar.dart';
import 'package:chat_bot_app/history/ui/views/history_view.dart';
import 'package:chat_bot_app/profile/ui/views/profile_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _activeIndex = 0;
  final List<Widget> _screens = [
    const ChatIntroView(),
    const HistoryView(),
    const ProfileView(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isLogged = SharedPrefs.getBool(isUserLoggedIn);
      if (context.mounted && isLogged) {
        snackBar(context, title: AppStrings.successfullyLoggedIn);
      }
      SharedPrefs.setBool(isUserLoggedIn, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt.get<ChatsCubit>()),
          BlocProvider(create: (context) => getIt.get<TopicsCubit>()),
        ],
        child: IndexedStack(index: _activeIndex, children: _screens),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _activeIndex,
        onDestinationSelected: (index) {
          setState(() {
            _activeIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue[80],
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: 5,
        destinations: [
          NavigationDestination(
            icon: const Icon(
              FontAwesomeIcons.solidComments,
              color: AppColors.primaryExtraLight,
            ),
            selectedIcon: const Icon(
              FontAwesomeIcons.solidComments,
              color: AppColors.primary,
            ),
            label: context.tr(LocalizationKeys.chat),
          ),
          NavigationDestination(
            icon: const Icon(
              FontAwesomeIcons.solidFolder,
              color: AppColors.primaryExtraLight,
            ),
            selectedIcon: const Icon(
              FontAwesomeIcons.solidFolder,
              color: AppColors.primary,
            ),
            label: context.tr(LocalizationKeys.myTopics),
          ),
          NavigationDestination(
            icon: const Icon(
              FontAwesomeIcons.solidUser,
              color: AppColors.primaryExtraLight,
            ),
            selectedIcon: const Icon(
              FontAwesomeIcons.solidUser,
              color: AppColors.primary,
            ),
            label: context.tr(LocalizationKeys.myProfile),
          ),
        ],
      ),
    );
  }
}
