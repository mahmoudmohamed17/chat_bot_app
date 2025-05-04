import 'package:chat_bot_app/auth/logic/repos/auth_repo.dart';
import 'package:chat_bot_app/core/errors/auth_failure.dart';
import 'package:chat_bot_app/core/errors/failure.dart';
import 'package:chat_bot_app/core/models/user_model.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl extends AuthRepo {
  final SupabaseAuthService supabaseAuthService;
  final SupabaseDatabaseService supabaseDatabaseService;

  AuthRepoImpl({
    required this.supabaseAuthService,
    required this.supabaseDatabaseService,
  });

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
  Future<bool> updateUserAuthData({String? email, String? password}) async {
    var response = await supabaseAuthService.updateUser(
      email: email,
      password: password,
    );
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

  @override
  Future<void> addUser(UserModel user) async {
    await supabaseDatabaseService.addUser(user);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await supabaseDatabaseService.deleteUser(userId);
  }

  @override
  Future<UserModel?> getUser(String userId) async {
    return await supabaseDatabaseService.getUser(userId);
  }

  @override
  Future<void> updateUserDate(UserModel user) async {
    await supabaseDatabaseService.updateUser(user);
  }
}
