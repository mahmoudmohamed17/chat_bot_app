import 'package:chat_bot_app/core/errors/failure.dart';
import 'package:chat_bot_app/core/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  User? getCurrentUser();

  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
  });
  Future<Either<Failure, GoogleSignInAccount?>> signInWithGoogle();

  Future<void> signOut();

  Future<bool> updateUserAuthData({String? email, String? password});

  Future<void> signInWithOTP({required String email});

  Future<void> resetPasswordForEmail({required String email});

  Future<void> verifyOTP({required String token, required String email});

  Future<UserModel?> getUser(String userId);

  Future<void> addUser(UserModel user);

  Future<void> updateUserDate(UserModel user);

  Future<void> deleteUser(String userId);

  Future<bool> checkUserExists(String userId);
}
