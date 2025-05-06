import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/auth/logic/repos/auth_repo.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo, this.usersCubit) : super(AuthInitial());

  final AuthRepo authRepo;
  final UsersCubit usersCubit;

  /// Used to save the current value of OTP code for verification
  String? _code;
  set code(String? value) => _code = value;
  String? get code => _code;

  User get currentUser => authRepo.getCurrentUser()!;

  Future<void> logIn({required String email, required String password}) async {
    emit(AuthLoading());
    var result = await authRepo.logIn(email: email, password: password);
    result.fold((failed) => emit(AuthFailed(errorMsg: failed.errorMsg)), (
      user,
    ) async {
      /// Gets the data of the current user logged in on this device
      await usersCubit.getUser();
      emit(AuthSuccess());
    });
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthLoading());
    var result = await authRepo.signUp(email: email, password: password);
    log('The sign up result: $result');
    result.fold(
      (failed) => emit(AuthFailed(errorMsg: failed.errorMsg)),
      (user) => emit(AuthSuccess()),
    );
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await authRepo.signOut();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    var result = await authRepo.signInWithGoogle();
    result.fold(
      (failed) {
        emit(GoogleAuthLoading());
        Future.delayed(const Duration(seconds: 3), () {
          emit(GoogleAuthFailed(errorMsg: failed.errorMsg));
        });
      },
      (user) async {
        emit(GoogleAuthLoading());
        await usersCubit.addGoogleUser(user!);
        await usersCubit.getUser();
        emit(GoogleAuthSuccess());
      },
    );
  }

  Future<void> resetPasswordForEmail({required String email}) async {
    emit(AuthLoading());
    try {
      await authRepo.resetPasswordForEmail(email: email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> updateUser({String? email, String? password}) async {
    emit(AuthLoading());
    var result = await authRepo.updateUserAuthData(
      email: email,
      password: password,
    );
    result
        ? emit(AuthSuccess())
        : emit(AuthFailed(errorMsg: 'Error while updating data.'));
  }

  Future<void> signInWithOTP({required String email}) async {
    emit(AuthLoading());
    try {
      await authRepo.signInWithOTP(email: email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> verifyOTP({required String email, required String token}) async {
    emit(AuthLoading());
    try {
      await authRepo.verifyOTP(token: token, email: email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailed(errorMsg: 'Invalid OTP entered.'));
    }
  }
}
