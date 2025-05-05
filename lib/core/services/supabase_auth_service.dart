import 'package:chat_bot_app/core/errors/custom_exception.dart';
import 'package:chat_bot_app/core/secret/api_strings.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    if (user == null) {
      throw CustomException(errorMsg: 'No user returned from Supabase.');
    }
    return user;
  }

  Future<User> signUp({required String email, required String password}) async {
    var response = await _client.signUp(email: email, password: password);
    var user = response.user;
    if (user == null) {
      throw CustomException(errorMsg: 'No user returned from Supabase.');
    }
    return user;
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: ApiStrings.appAndroidClientId,
      serverClientId: ApiStrings.appWebClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final accessToken = googleAuth?.accessToken;
    final idToken = googleAuth?.idToken;
    if (accessToken == null || idToken == null) {
      return null;
    }
    await _client.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    return googleUser;
  }

  Future<void> signOut() async {
    await _client.signOut();
  }

  Future<bool> updateUser({String? email, String? password}) async {
    var response = await _client.updateUser(
      UserAttributes(email: email, password: password),
    );
    var result = response.user;
    return result != null ? true : false;
  }

  Future<void> signInWithOTP({required String email}) async {
    await _client.signInWithOtp(email: email);
  }

  Future<void> verifyOTP({required String token, required String email}) async {
    await _client.verifyOTP(type: OtpType.email, token: token, email: email);
  }

  Future<void> resetPasswordForEmail({required String email}) async {
    await _client.resetPasswordForEmail(email);
  }
}
