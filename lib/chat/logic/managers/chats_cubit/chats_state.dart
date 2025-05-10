part of 'chats_cubit.dart';

sealed class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

final class ChatsInitial extends ChatsState {}

final class ChatLoading extends ChatsState {}

final class ChatsSuccess extends ChatsState {
  final String chatId;

  const ChatsSuccess({required this.chatId});
}

final class ChatsFailed extends ChatsState {
  final String errorMsg;

  const ChatsFailed({required this.errorMsg});
}

final class TopicsLoading extends ChatsState {}

final class TopicsSuccess extends ChatsState {}

final class TopicsFailed extends ChatsState {
  final String errorMsg;

  const TopicsFailed({required this.errorMsg});
}
