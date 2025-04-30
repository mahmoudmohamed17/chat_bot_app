import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final client = Supabase.instance.client;

  Future<User> logIn({required String email, required String password}) async {
    var response = await client.auth.signInWithPassword(
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
    var response = await client.auth.signUp(
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
    await client.auth.signOut();
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
    var response = await client.auth.updateUser(
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

  Future<void> signInWithOTP({required String phone}) async {
    await client.auth.signInWithOtp(
      phone: phone,
      shouldCreateUser: false,
      channel: OtpChannel.whatsapp,
    );
  }

  Future<void> resetPassword({required String email}) async {
    await client.auth.resetPasswordForEmail(email);
  }
}
