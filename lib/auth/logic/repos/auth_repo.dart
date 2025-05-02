import 'package:chat_bot_app/core/errors/failure.dart';
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
    String? name,
    String? profileImage,
    String? phoneNumber,
    String? gender,
    String? dateOfBirth,
  });

  Future<void> signOut();

  Future<bool> updateUser({required User user});

  Future<void> signInWithOTP({required String email});

  Future<void> resetPasswordWithEmail({required String email});

  Future<User?> verifyOTP({required String token, required String email});
}
