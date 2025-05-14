import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/routing/app_routing.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<ModeCubit>(),
      child: BlocBuilder<ModeCubit, bool>(
        builder: (context, state) {
          var cubit = context.read<ModeCubit>();
          return MaterialApp.router(
            theme: ThemeData(
              brightness: cubit.state ? Brightness.dark : Brightness.light,
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouting.router,
          );
        },
      ),
    );
  }
}
