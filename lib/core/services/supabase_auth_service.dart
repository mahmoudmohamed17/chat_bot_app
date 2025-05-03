import 'dart:developer';

import 'package:chat_bot_app/core/errors/custom_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final _client = Supabase.instance.client.auth;

  User? get currentUser => _client.currentUser;

  Future<User> logIn({required String email, required String password}) async {
    var response = await _client.signInWithPassword(
      email: email,
      password: password,
    );
    var user = response.user;
    if(user == null) {
      throw CustomException(errorMsg: 'No user returned from Supabase.');
    }
    log('Current user data: $currentUser');
    return user;
  }

  Future<User> signUp({
    required String email,
    required String password,
    required String name,
    required String profileImage,
    required String phoneNumber,
    required String gender,
    required String dateOfBirth,
  }) async {
    var response = await _client.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
        'profileImage': profileImage,
        'phone': phoneNumber,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
        'password': password,
      },
    );
    var user = response.user;
     if(user == null) {
      throw CustomException(errorMsg: 'No user returned from Supabase.');
    }
    log('Current user data: $currentUser');
    return user;
  }

  Future<void> signOut() async {
    await _client.signOut();
  }

  Future<bool> updateUser({required User user}) async {
    var response = await _client.updateUser(
      UserAttributes(
        email: user.email,
        phone: user.phone,
        data: {
          'name': user.userMetadata!['name'],
          'profileImage': user.userMetadata!['profileImage'],
          'gender': user.userMetadata!['gender'],
          'dateOfBirth': user.userMetadata!['dateOfBirth'],
        },
      ),
    );
    var result = response.user;
    return result != null ? true : false;
  }

  Future<void> signInWithOTP({required String email}) async {
    await _client.signInWithOtp(email: email);
  }

  Future<User?> verifyOTP({
    required String token,
    required String email,
  }) async {
    var response = await _client.verifyOTP(
      type: OtpType.email,
      token: token,
      email: email,
    );
    var user = response.user;
    return user;
  }

  Future<void> resetPasswordWithEmail({required String email}) async {
    await _client.resetPasswordForEmail(email);
  }
}
