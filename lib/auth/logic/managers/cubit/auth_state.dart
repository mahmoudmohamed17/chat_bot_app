part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFailed extends AuthState {
  final String errorMsg;

  AuthFailed({required this.errorMsg});
}

final class GoogleAuthLoading extends AuthState {}

final class GoogleAuthSuccess extends AuthState {}

final class GoogleAuthFailed extends AuthState {
  final String errorMsg;

  GoogleAuthFailed({required this.errorMsg});
}
