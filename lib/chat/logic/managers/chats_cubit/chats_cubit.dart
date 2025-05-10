import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:equatable/equatable.dart';
part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this.supabeAuthService, this.supabaseDatabaseService, this.topicsCubit) : super(ChatsInitial());

  final SupabaseAuthService supabeAuthService;
  final SupabaseDatabaseService supabaseDatabaseService;
  late TopicsCubit? topicsCubit;
 
  String? chatId;

  Future<void> createChat() async {
    emit(ChatLoading());
    try {
      final id = await supabaseDatabaseService.createChat(
        supabeAuthService.currentUser!.id,
      );
      chatId = id;
      await topicsCubit!.addTopic();
      emit(ChatsSuccess());
    } catch (e) {
      emit(ChatsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      await supabaseDatabaseService.deleteChat(chatId);
      emit(ChatsSuccess());
    } catch (e) {
      emit(ChatsFailed(errorMsg: e.toString()));
    }
  }

  Future<void> deleteAllMessages(String chatId) async {
    try {
      await supabaseDatabaseService.deleteAllMessages(chatId);
      emit(ChatsSuccess());
    } catch (e) {
      emit(ChatsFailed(errorMsg: e.toString()));
    }
  }
}
