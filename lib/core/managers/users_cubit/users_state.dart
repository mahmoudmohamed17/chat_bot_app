part of 'users_cubit.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class UsersSuccess extends UsersState {}

final class UsersFailed extends UsersState {
  final String errorMsg;

  const UsersFailed({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
