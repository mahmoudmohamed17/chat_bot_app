import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/core/constants/dummy.dart';
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

  /// To save the current topic deleted that would be used with [deleteTopicChatAndMessages] method
  String? currentTopicChatId;

  /// Creating a topic related to a specific chat using its [Chat ID]
  /// Note: we need to check the current state in case we do not
  /// have to load the topics from database each time we create new one.
  /// Instead of this, we use the current state to save the topics.
  Future<void> createTopic(String chatId) async {
    try {
      var newTopic = await supabaseDatabaseService.addTopic(
        chatId,
        supabaseAuthService.currentUser?.id ?? dummyUserId,
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
  Future<void> deleteTopic({required TopicModel topic}) async {
    currentTopicChatId = topic.forChat;
    emit(TopicsLoading());
    try {
      await supabaseDatabaseService.deleteTopic(topic.id!);
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

  Future<void> deleteAllTopics() async {
    emit(TopicsLoading());
    try {
      await supabaseDatabaseService.deleteAllTopics();
      emit(TopicsEmpty());
    } catch (e) {
      log('Error with deleteAllTopics: ${e.toString()}');
      emit(TopicsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> deleteTopicChatAndMessages({
    required Future<void> Function(String chatId) deleteChat,
    required Future<void> Function(String chatId) deleteMessages,
  }) async {
    await deleteMessages(currentTopicChatId!);
    await deleteChat(currentTopicChatId!);
  }

  Future<void> deleteAllTopicsWithRelatedData({
    required Future<void> Function() deleteAllChats,
    required Future<void> Function() deleteAllMessages,
  }) async {
    await deleteAllChats();
    await deleteAllMessages();
  }

  Future<void> loadTopics() async {
    try {
      final topics = await supabaseDatabaseService.getTopics(
        supabaseAuthService.currentUser?.id ?? dummyUserId,
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
