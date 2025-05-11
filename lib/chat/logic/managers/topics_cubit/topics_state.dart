part of 'topics_cubit.dart';

sealed class TopicsState extends Equatable {
  const TopicsState();

  @override
  List<Object> get props => [];
}

final class TopicsInitial extends TopicsState {}

final class TopicsSuccess extends TopicsState {
  final List<TopicModel> topics;

  const TopicsSuccess({required this.topics});
}

final class TopicsFailed extends TopicsState {
  final String errorMsg;

  const TopicsFailed({required this.errorMsg});
}

final class TopicsEmpty extends TopicsState {}
