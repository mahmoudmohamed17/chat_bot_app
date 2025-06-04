import 'package:chat_bot_app/chat/ui/views/chat_intro_view.dart';
import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:chat_bot_app/history/ui/views/history_view.dart';
import 'package:chat_bot_app/profile/ui/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
      bottomNavigationBar: GNav(
        selectedIndex: _activeIndex,
        onTabChange: (index) {
          setState(() {
            _activeIndex = index;
          });
        },
        tabBorderRadius: 24,
        curve: Curves.easeOutExpo,
        textStyle: AppTextStyles.semiBold16.copyWith(color: Colors.white),
        gap: 8,
        color: Colors.grey[350],
        activeColor: Colors.white,
        iconSize: 24,
        backgroundColor: Colors.white,
        tabBackgroundColor: AppColors.primary,
        tabMargin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        tabs: const [
          GButton(
            icon: FontAwesomeIcons.solidComments,
            text: AppStrings.chat,
            gap: 12,
          ),
          GButton(
            icon: FontAwesomeIcons.solidFolder,
            text: AppStrings.myTopics,
            gap: 12,
          ),
          GButton(
            icon: FontAwesomeIcons.solidUser,
            text: AppStrings.myProfile,
            gap: 12,
          ),
        ],
      ),
    );
  }
}
