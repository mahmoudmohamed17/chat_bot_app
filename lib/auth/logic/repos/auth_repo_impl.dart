import 'package:chat_bot_app/auth/logic/repos/auth_repo.dart';
import 'package:chat_bot_app/core/errors/auth_failure.dart';
import 'package:chat_bot_app/core/errors/failure.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl extends AuthRepo {
  final SupabaseAuthService supabaseAuthService;

  AuthRepoImpl({required this.supabaseAuthService});

  @override
  User? getCurrentUser() => supabaseAuthService.currentUser;

  @override
  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      var response = await supabaseAuthService.logIn(
        email: email,
        password: password,
      );
      return right(response);
    } on AuthException catch (e) {
      return left(AuthFailure(errorMsg: e.message));
    } catch (e) {
      return left(AuthFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    String? name,
    String? profileImage,
    String? phoneNumber,
    String? gender,
    String? dateOfBirth,
  }) async {
    try {
      var response = await supabaseAuthService.signUp(
        email: email,
        password: password,
      );
      return right(response);
    } on AuthException catch (e) {
      return left(AuthFailure(errorMsg: e.message));
    } catch (e) {
      return left(AuthFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    await supabaseAuthService.signOut();
  }

  @override
  Future<bool> updateUser({String? email, String? password}) async {
    var response = await supabaseAuthService.updateUser(email: email, password: password);
    return response;
  }

  @override
  Future<void> resetPasswordForEmail({required String email}) async {
    await supabaseAuthService.resetPasswordForEmail(email: email);
  }

  @override
  Future<void> signInWithOTP({required String email}) async {
    await supabaseAuthService.signInWithOTP(email: email);
  }

  @override
  Future<User?> verifyOTP({
    required String token,
    required String email,
  }) async {
    var user = await supabaseAuthService.verifyOTP(token: token, email: email);
    return user;
  }
}
