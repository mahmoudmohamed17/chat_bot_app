import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/core/constants/dummy.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:equatable/equatable.dart';
part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this.supabeAuthService, this.supabaseDatabaseService)
    : super(ChatsInitial());

  final SupabaseAuthService supabeAuthService;
  final SupabaseDatabaseService supabaseDatabaseService;

  String? currentChatId;

  Future<String?> createChat() async {
    emit(ChatLoading());
    try {
      final id = await supabaseDatabaseService.createChat(
        supabeAuthService.currentUser?.id ?? dummyUserId,
      );
      currentChatId = id;
      log('Chat created with ID: $id');
      emit(ChatsSuccess());
      return id;
    } catch (e) {
      emit(ChatsFailed(errorMsg: e.toString()));
      return null;
    }
  }

  Future<void> deleteChat(String chatId) async {
    await _safeExcute(action: () => supabaseDatabaseService.deleteChat(chatId));
  }

  Future<void> deleteAllChats() async {
    await _safeExcute(
      action:
          () => supabaseDatabaseService.deleteAllChats(
            userId: supabeAuthService.currentUser?.id ?? dummyUserId,
          ),
    );
  }

  Future<void> _safeExcute({required Future<void> Function() action}) async {
    try {
      await action();
      emit(ChatsSuccess());
    } catch (e) {
      log('Error with _safeExcute: ${e.toString()}');
      emit(ChatsFailed(errorMsg: e.toString()));
    }
  }
}
