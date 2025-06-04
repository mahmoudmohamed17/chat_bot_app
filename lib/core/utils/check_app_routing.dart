import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/routing/routes.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';

String checkAppRouting() {
  return Routes.mainView;
  // return SharedPrefs.getBool(isOnboardingSeen)
  //     ? SharedPrefs.getBool(isUserAuthenticated)
  //         ? Routes.mainView
  //         : Routes.initAuthView
  //     : Routes.onboardingView;
}
