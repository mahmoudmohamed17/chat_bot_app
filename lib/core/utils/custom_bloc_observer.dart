import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('Change: $change on Bloc: $bloc');
  }

  @override
  void onClose(BlocBase bloc) {
    log('Close bloc: $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    log('Create bloc: $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {}

  @override
  void onEvent(Bloc bloc, Object? event) {}

  @override
  void onTransition(Bloc bloc, Transition transition) {}
}
