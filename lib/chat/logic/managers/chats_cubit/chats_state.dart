part of 'chats_cubit.dart';

sealed class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

final class ChatsInitial extends ChatsState {}

final class ChatLoading extends ChatsState {}

final class ChatsSuccess extends ChatsState {}

final class ChatsFailed extends ChatsState {
  final String errorMsg;

  const ChatsFailed({required this.errorMsg});
}
