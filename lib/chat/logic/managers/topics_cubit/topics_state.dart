part of 'topics_cubit.dart';

sealed class TopicsState extends Equatable {
  const TopicsState();
}

final class TopicsInitial extends TopicsState {
  @override
  List<Object> get props => [];
}

final class TopicsLoading extends TopicsState {
  @override
  List<Object> get props => [];
}

final class TopicsSuccess extends TopicsState {
  final List<TopicModel> topics;
  @override
  List<Object> get props => [topics];
  const TopicsSuccess({required this.topics});
}

final class TopicsFailed extends TopicsState {
  final String errorMsg;
  @override
  List<Object> get props => [errorMsg];
  const TopicsFailed({required this.errorMsg});
}

final class TopicsEmpty extends TopicsState {
  @override
  List<Object> get props => [];
}
