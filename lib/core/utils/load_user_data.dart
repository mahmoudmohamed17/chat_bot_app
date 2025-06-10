import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/di/setup_locator.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';

Future<void> loadUserData() async {
  final cubit = getIt.get<UsersCubit>();
  final isAuth = SharedPrefs.getBool(isUserAuthenticated);
  if (isAuth) {
    await cubit.getUser();
  } else {
    return;
  }
}
