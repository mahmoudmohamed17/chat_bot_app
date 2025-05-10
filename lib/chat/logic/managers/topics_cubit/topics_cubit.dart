import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:chat_bot_app/history/logic/models/topic_model.dart';
import 'package:equatable/equatable.dart';

part 'topics_state.dart';

class TopicsCubit extends Cubit<TopicsState> {
  TopicsCubit(this.supabaseDatabaseService, this.chatsCubit) : super(TopicsInitial());

  final SupabaseDatabaseService supabaseDatabaseService;
  final ChatsCubit chatsCubit;
  List<TopicModel>? topics;

  Future<void> addTopic() async {
    try {
      await supabaseDatabaseService.addTopic(chatsCubit.chatId!);
      await getTopics();
    } catch (e) {
      emit(TopicsFailed(errorMsg: e.toString()));
    }
  }

  /// Deleting topic means deleting the chat related to it and also the messages
  Future<void> deleteTopic({required TopicModel topic}) async {
    try {
      await supabaseDatabaseService.deleteTopic(topic.id!);
      await chatsCubit.deleteAllMessages(topic.forChat!);
      await chatsCubit.deleteChat(topic.forChat!);
      await getTopics();
    } catch (e) {
      emit(TopicsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> getTopics() async {
    try {
      topics = await supabaseDatabaseService.getTopics();
      emit(TopicsSuccess());
    } catch (e) {
      emit(TopicsFailed(errorMsg: e.toString()));
    }
  }
}
