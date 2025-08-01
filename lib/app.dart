import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/routing/app_routing.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ModeCubit>(create: (context) => getIt.get<ModeCubit>()),
        BlocProvider<AuthCubit>(create: (context) => getIt.get<AuthCubit>()),
        BlocProvider<UsersCubit>(create: (context) => getIt.get<UsersCubit>()),
      ],
      child: BlocBuilder<ModeCubit, bool>(
        builder: (context, state) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              brightness: state ? Brightness.dark : Brightness.light,
              useMaterial3: true,
            ),
            builder: (context, child) {
              return Directionality(
                textDirection: ui.TextDirection.ltr,
                child: child!,
              );
            },
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouting.router,
          );
        },
      ),
    );
  }
}
