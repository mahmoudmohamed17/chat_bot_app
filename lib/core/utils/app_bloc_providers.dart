import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {
  static List<BlocProvider> providers = [
    BlocProvider.value(value: getIt.get<ModeCubit>()),
    BlocProvider.value(value: getIt.get<AuthCubit>()),
    BlocProvider.value(value: getIt.get<UsersCubit>()),
  ];
}