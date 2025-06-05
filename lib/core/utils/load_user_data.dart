import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';

Future<void> loadUserData() async {
  final cubit = getIt.get<UsersCubit>();
  await cubit.getUser();
}
