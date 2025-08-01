import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/core/constants/dummy.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:chat_bot_app/history/logic/models/topic_model.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
part 'topics_state.dart';

class TopicsCubit extends Cubit<TopicsState> {
  TopicsCubit(this.supabaseDatabaseService, this.supabaseAuthService)
    : super(TopicsInitial()) {
    loadTopics();
  }

  final SupabaseDatabaseService supabaseDatabaseService;
  final SupabaseAuthService supabaseAuthService;

  /// To save the current topic deleted that would be used with [deleteTopicData] method
  String? currentTopicId;

  /// Creating a topic related to a specific chat using its [Chat ID]
  /// Note: we need to check the current state in case we do not
  /// have to load the topics from database each time we create new one.
  /// Instead of this, we use the current state to save the topics.
  Future<void> createTopic({String? chatId, String? title}) async {
    try {
      final now = DateTime.now();
      final time = DateFormat('EEEE, MMM d, yyyy').format(now);
      final newTopic = await supabaseDatabaseService.addTopic(
        chatId: chatId,
        userId: supabaseAuthService.currentUser?.id ?? dummyUserId,
        title: title,
        createdAt: time,
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

  Future<void> deleteTopic({required TopicModel topic}) async {
    currentTopicId = topic.id;
    log('Deleting topic with ID: ${topic.id}');
    emit(TopicsLoading());
    try {
      // Delete topic with its chat and messages as well
      await supabaseDatabaseService.deleteTopicWithRelatedData(
        topicId: topic.id!,
        chatId: topic.forChat!,
      );
      if (state is TopicsSuccess) {
        final current = (state as TopicsSuccess).topics;
        final updatedTopics = current.where((t) => t.id != topic.id).toList();
        if (updatedTopics.isEmpty) {
          emit(TopicsEmpty());
        } else {
          emit(TopicsSuccess(topics: updatedTopics));
        }
      } else {
        loadTopics();
      }
    } catch (e) {
      emit(TopicsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> deleteAllTopics() async {
    emit(TopicsLoading());
    try {
      // Delele all topics with the with all messages
      await supabaseDatabaseService.deleteAllTopicsWithRelatedData(
        userId: supabaseAuthService.currentUser?.id ?? dummyUserId,
      );
      emit(TopicsEmpty());
    } catch (e) {
      log('Error with deleteAllTopics: ${e.toString()}');
      emit(TopicsFailed(errorMsg: e.toString()));
    }
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
