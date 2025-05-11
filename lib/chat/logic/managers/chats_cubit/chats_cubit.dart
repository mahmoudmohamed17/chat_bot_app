import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:equatable/equatable.dart';
part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(
    this.supabeAuthService,
    this.supabaseDatabaseService,
  ) : super(ChatsInitial());

  final SupabaseAuthService supabeAuthService;
  final SupabaseDatabaseService supabaseDatabaseService;

  String? chatId;

  Future<String?> createChat() async {
    emit(ChatLoading());
    try {
      final id = await supabaseDatabaseService.createChat(
        supabeAuthService.currentUser!.id,
      );
      chatId = id;
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

  Future<void> deleteAllMessages(String chatId) async {
    await _safeExcute(
      action: () => supabaseDatabaseService.deleteAllMessages(chatId),
    );
  }

  Future<void> _safeExcute({required Future<void> Function() action}) async {
    try {
      await action();
      emit(ChatsSuccess());
    } catch (e) {
      emit(ChatsFailed(errorMsg: e.toString()));
    }
  }
}
