import 'package:chat_bot_app/chat/ui/views/chat_intro_view.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/history/ui/views/history_view.dart';
import 'package:chat_bot_app/profile/ui/views/profile_view.dart';
import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
    // if (SharedPrefs.getBool(isUserAuthenticated)) {
    //   final usersCubit = context.read<UsersCubit>();
    //   usersCubit.getUser();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _activeIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _activeIndex,
        onDestinationSelected: (index) {
          setState(() {
            _activeIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue[80],

        elevation: 5,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.solidComments,
              color: AppColors.primaryExtraLight,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.solidComments,
              color: AppColors.primary,
            ),
            label: AppStrings.chat,
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.solidFolder,
              color: AppColors.primaryExtraLight,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.solidFolder,
              color: AppColors.primary,
            ),
            label: AppStrings.myTopics,
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.solidUser,
              color: AppColors.primaryExtraLight,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.solidUser,
              color: AppColors.primary,
            ),
            label: AppStrings.myProfile,
          ),
        ],
      ),
    );
  }
}
