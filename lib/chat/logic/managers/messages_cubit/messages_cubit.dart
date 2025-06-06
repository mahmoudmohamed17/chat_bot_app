import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/chat/logic/services/gemini_service.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:equatable/equatable.dart';
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this.supabaseDatabaseService, this.geminiService)
    : super(MessagesInitial());

  final SupabaseDatabaseService supabaseDatabaseService;
  final GeminiService geminiService;

  Future<void> sendMessage({
    required String chatId,
    String? message, // Prompt
  }) async {
    try {
      await supabaseDatabaseService.addMessage(
        chatId: chatId,
        message: message,
        sender: AppStrings.user,
      );
      emit(MessagesSuccess());
    } catch (e) {
      emit(MessagesFailed());
    }
  }

  Future<void> getBotResponse({required String chatId, String? message}) async {
    emit(MessagesLoading());
    try {
      final botResponse = await geminiService.askGemini(prompt: message!);
      await supabaseDatabaseService.addMessage(
        chatId: chatId,
        message: botResponse,
        sender: AppStrings.bot,
      );
      emit(MessagesSuccess());
    } catch (e) {
      emit(MessagesFailed());
    }
  }
}
