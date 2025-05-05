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

  User get currentUser => authRepo.getCurrentUser()!;

  Future<void> logIn({required String email, required String password}) async {
    emit(AuthLoading());
    var result = await authRepo.logIn(email: email, password: password);
    result.fold(
      (failed) => emit(AuthFailed(errorMsg: failed.errorMsg)),
      (user) => emit(AuthSuccess()),
    );
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
    await authRepo.signOut();
    emit(AuthSuccess());
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    var result = await authRepo.signInWithGoogle();
    result.fold((failed) => emit(AuthFailed(errorMsg: failed.errorMsg)), (
      user,
    ) async {
      await usersCubit.addGoogleUser(user!);
      await usersCubit.getUser();
      emit(AuthSuccess());
    });
  }

  Future<void> resetPasswordForEmail({required String email}) async {
    emit(AuthLoading());
    await authRepo.resetPasswordForEmail(email: email);
    emit(AuthSuccess());
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
    await authRepo.signInWithOTP(email: email);
    emit(AuthSuccess());
  }

  Future<void> verifyOTP({required String email, required String token}) async {
    emit(AuthLoading());
    var result = await authRepo.verifyOTP(token: token, email: email);
    result != null
        ? emit(AuthSuccess())
        : emit(AuthFailed(errorMsg: 'Error verifying the OTP'));
  }
}
