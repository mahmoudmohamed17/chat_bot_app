import 'package:chat_bot_app/core/errors/failure.dart';
import 'package:chat_bot_app/core/models/user_model.dart';
import 'package:dartz/dartz.dart';
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

  Future<void> signOut();

  Future<bool> updateUserAuthData({String? email, String? password});

  Future<void> signInWithOTP({required String email});

  Future<void> resetPasswordForEmail({required String email});

  Future<User?> verifyOTP({required String token, required String email});

  Future<UserModel?> getUser(int userId);

  Future<void> addUser(UserModel user);

  Future<void> updateUserDate(UserModel user);

  Future<void> deleteUser(int userId);
}
