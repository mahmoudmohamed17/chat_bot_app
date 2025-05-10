import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:chat_bot_app/history/logic/models/topic_model.dart';
import 'package:equatable/equatable.dart';
part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());

  final supabeAuthService = SupabaseAuthService();
  final supabaseDatabaseService = SupabaseDatabaseService();

  String? _chatId;
  List<TopicModel>? topics;

  Future<void> createChat() async {
    emit(ChatLoading());
    try {
      final chatId = await supabaseDatabaseService.createChat(
        supabeAuthService.currentUser!.id,
      );
      _chatId = chatId;
      await addTopic();
      emit(ChatsSuccess(chatId: chatId));
    } catch (e) {
      emit(ChatsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> addTopic() async {
    try {
      await supabaseDatabaseService.addTopic(_chatId!);
      await getTopics();
    } catch (e) {
      emit(TopicsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> deleteTopic(String topicId) async {
    try {
      await supabaseDatabaseService.deleteTopic(topicId);
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
