import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:chat_bot_app/history/logic/models/topic_model.dart';
import 'package:equatable/equatable.dart';
part 'topics_state.dart';

class TopicsCubit extends Cubit<TopicsState> {
  TopicsCubit(this.supabaseDatabaseService, this.supabaseAuthService)
    : super(TopicsInitial()) {
    loadTopics();
  }

  final SupabaseDatabaseService supabaseDatabaseService;
  final SupabaseAuthService supabaseAuthService;

  Future<void> addTopic(String chatId) async {
    try {
      var newTopic = await supabaseDatabaseService.addTopic(
        chatId,
        supabaseAuthService.currentUser!.id,
      );
      if (state is TopicsSuccess) {
        final current = (state as TopicsSuccess).topics;
        emit(TopicsSuccess(topics: [...current, newTopic]));
      } else {
        await loadTopics();
      }
    } catch (e) {
      emit(TopicsFailed(errorMsg: e.toString()));
    }
  }

  /// Deleting topic means deleting the chat related to it and also the messages
  Future<void> deleteTopic({
    required TopicModel topic,
    required Future<void> Function(String chatId) deleteChat,
    required Future<void> Function(String chatId) deleteMessages,
  }) async {
    emit(TopicsLoading());
    try {
      await supabaseDatabaseService.deleteTopic(topic.id!);
      await deleteMessages(topic.forChat!);
      await deleteChat(topic.forChat!);
      if (state is TopicsSuccess) {
        final updated =
            (state as TopicsSuccess).topics
                .where((t) => t.id != topic.id)
                .toList();
        emit(updated.isEmpty ? TopicsEmpty() : TopicsSuccess(topics: updated));
      } else {
        await loadTopics();
      }
    } catch (e) {
      log('Error with deleteTopic: ${e.toString()}');
      emit(TopicsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> loadTopics() async {
    try {
      final topics = await supabaseDatabaseService.getTopics(
        supabaseAuthService.currentUser!.id,
      );
      if (topics.isEmpty) {
        emit(TopicsEmpty());
      } else {
        emit(TopicsSuccess(topics: topics));
      }
    } catch (e) {
      log('Error with loadTopics: ${e.toString()}');
      emit(TopicsFailed(errorMsg: e.toString()));
    }
  }
}
