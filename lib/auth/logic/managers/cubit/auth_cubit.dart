import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/auth/logic/repos/auth_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  /// Used to save the current value of OTP code for verification
  String? _code;
  set code(String? value) => _code = value;
  String? get code => _code;

  User? get currentUser => authRepo.getCurrentUser();

  /// To save the current password entered by user for further processing
  String? _password;
  set password(String? value) => _password = value;
  String? get password => _password;

  Future<void> logIn({
    required String email,
    required String password,
    Future<void> Function()? getUser,
  }) async {
    emit(AuthLoading());
    var result = await authRepo.logIn(email: email, password: password);
    result.fold(
      (failed) {
        log('Error with AuthFailed: ${failed.errorMsg}');
        emit(AuthFailed(errorMsg: failed.errorMsg));
      },
      (user) async {
        await getUser!();
        emit(AuthSuccess());
      },
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
    try {
      await authRepo.signOut();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailed(errorMsg: e.toString()));
    }
  }

  Future<void> signInWithGoogle({
    Future<void> Function(GoogleSignInAccount user)? addGoogleUser,
    Future<void> Function()? getUser,
  }) async {
    emit(GoogleAuthLoading());
    var result = await authRepo.signInWithGoogle();
    result.fold(
      (failed) {
        log('Google sign in failed: ${failed.errorMsg}');
        Future.delayed(const Duration(seconds: 3), () {
          emit(GoogleAuthFailed(errorMsg: failed.errorMsg));
        });
      },
      (user) async {
        final isFound = await authRepo.checkUserExists(user!.id);
        if (!isFound) {
          log('User not found in database, adding new user: ${user.email}');
          await addGoogleUser!(user);
        }
        await getUser!();
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
