import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:equatable/equatable.dart';
part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());

  final supabeAuthService = SupabaseAuthService();
  final supabaseDatabaseService = SupabaseDatabaseService();

  Future<void> createChat() async {
    emit(ChatLoading());
    try {
      var chatId = await supabaseDatabaseService.createChat(
        supabeAuthService.currentUser!.id,
      );
      log(
        'New generated chat id: $chatId\nFor user with id: ${supabeAuthService.currentUser!.id}',
      );
      emit(ChatsSuccess(chatId: chatId));
    } catch (e) {
      log('Current user id: ${supabeAuthService.currentUser!.id}');
      log('Error with creating chat: ${e.toString()}');
      emit(ChatsFailed(errorMsg: e.toString()));
    }
  }
}
