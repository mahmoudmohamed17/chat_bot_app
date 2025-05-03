import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/auth/logic/repos/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  String? _email;
  String? _password;
  String? _name;
  String? _phoneNumber;
  String? _profileImage;
  String? _gender;
  String? _dateOfBirth;

  User get currentUser => authRepo.getCurrentUser()!;

  Future<void> logIn({required String email, required String password}) async {
    emit(AuthLoading());
    var result = await authRepo.logIn(email: email, password: password);
    result.fold(
      (failed) => emit(AuthFailed(errorMsg: failed.errorMsg)),
      (user) => emit(AuthSuccess()),
    );
  }

  Future<void> signUp() async {
    emit(AuthLoading());
    var result = await authRepo.signUp(
      email: email,
      password: password,
      name: name,
      phoneNumber: phoneNumber,
      profileImage: profileImage,
      gender: gender,
      dateOfBirth: dateOfBirth,
    );
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

  Future<void> resetPasswordWithEmail({required String email}) async {
    emit(AuthLoading());
    await authRepo.resetPasswordWithEmail(email: email);
    emit(AuthSuccess());
  }

  Future<void> updateUser({
    String? email,
    String? name,
    String? phoneNumber,
    String? profileImage,
    String? gender,
    String? dateOfBirth,
  }) async {
    emit(AuthLoading());
    var user = User(
      id: currentUser.id,
      appMetadata: currentUser.appMetadata,
      userMetadata: {
        'name': name,
        'profileImage': profileImage,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
      },
      aud: currentUser.aud,
      createdAt: currentUser.createdAt,
      email: email,
      phone: phoneNumber,
    );
    var result = await authRepo.updateUser(user: user);
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

  updateUI() {
    emit(AuthInitial());
  }

  set email(String email) => _email = email;
  String get email => _email!;
  set password(String password) => _password = password;
  String get password => _password!;
  set name(String name) => _name = name;
  String get name => _name!;
  set phoneNumber(String phoneNumber) => _phoneNumber = phoneNumber;
  String get phoneNumber => _phoneNumber!;
  set profileImage(String profileImage) => _profileImage = profileImage;
  String get profileImage => _profileImage!;
  set gender(String gender) => _gender = gender;
  String get gender => _gender!;
  set dateOfBirth(String dateOfBirth) => _dateOfBirth = dateOfBirth;
  String get dateOfBirth => _dateOfBirth!;
}
