import 'package:chat_bot_app/chat/ui/views/chat_intro_view.dart';
import 'package:chat_bot_app/core/theme/app_colors.dart';
import 'package:chat_bot_app/core/theme/app_text_styles.dart';
import 'package:chat_bot_app/history/ui/views/history_view.dart';
import 'package:chat_bot_app/profile/ui/views/profile_view.dart';
import 'package:flutter/material.dart';
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
        curve: Curves.easeOutExpo, // tab animation curves
        textStyle: AppTextStyles.semiBold16.copyWith(color: Colors.white),
        gap: 8, // the tab button gap between icon and text
        color: Colors.grey[350], // unselected icon color
        activeColor: Colors.white, // selected icon and text color
        iconSize: 24, // tab button icon size
        backgroundColor: Colors.white,
        tabBackgroundColor: AppColors.primary, // selected tab background color
        tabMargin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ), // navigation bar padding
        tabs: const [
          GButton(icon: FontAwesomeIcons.solidComments, text: 'Chat', gap: 12),
          GButton(icon: FontAwesomeIcons.solidFolder, text: 'Topics', gap: 12),
          GButton(icon: FontAwesomeIcons.solidUser, text: 'Profile', gap: 12),
        ],
      ),
    );
  }
}
