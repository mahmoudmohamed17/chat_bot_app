import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/app.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/networking/init_supabase.dart';
import 'package:chat_bot_app/core/utils/custom_bloc_observer.dart';
import 'package:chat_bot_app/core/utils/load_user_data.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initSupabase();
  await SharedPrefs.init();
  setupLocator();
  Bloc.observer = CustomBlocObserver();
  await loadUserData();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}
