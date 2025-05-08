import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/utils/shared_prefs.dart';

class ModeCubit extends Cubit<bool> {
  ModeCubit() : super(false) {
    _loadMode();
  }

  void _loadMode() {
    final mode = SharedPrefs.getBool(isDarkMode);
    emit(mode);
  }

  Future<void> toggleMode(bool value) async {
    await SharedPrefs.setBool(isDarkMode, value);
    emit(value);
  }
}
