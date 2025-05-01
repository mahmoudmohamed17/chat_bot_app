import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final _client = Supabase.instance.client.auth;

  User? get currentUser => _client.currentUser;

  Future<User> logIn({required String email, required String password}) async {
    var response = await _client.signInWithPassword(
      email: email,
      password: password,
    );
    var user = response.user!;
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
      phone: phoneNumber,
      data: {
        'name': name,
        'profileImage': profileImage,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
      },
    );
    var user = response.user!;
    return user;
  }

  Future<void> signOut() async {
    await _client.signOut();
  }

  Future<bool> updateUser({
    String? email,
    String? password,
    String? name,
    String? phoneNumber,
    String? profileImage,
    String? gender,
    String? dateOfBirth,
  }) async {
    var response = await _client.updateUser(
      UserAttributes(
        email: email,
        phone: phoneNumber,
        password: password,
        data: {
          'name': name,
          'profileImage': profileImage,
          'gender': gender,
          'dateOfBirth': dateOfBirth,
        },
      ),
    );
    var user = response.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  /// Here we will follow sending and verivying an OTP
  /// with only the phone number as the email is not setup
  /// or configured in a good maner

  Future<void> signInWithOTP({required String phone}) async {
    await _client.signInWithOtp(phone: phone, shouldCreateUser: false);
  }

  Future<User> verifyOTP({
    required String token,
    required String phoneNumber,
  }) async {
    var response = await _client.verifyOTP(
      type: OtpType.sms,
      token: token,
      phone: phoneNumber,
    );
    var user = response.user!;
    return user;
  }

  Future<void> resetPasswordWithEmail({required String email}) async {
    await _client.resetPasswordForEmail(email);
  }
}
