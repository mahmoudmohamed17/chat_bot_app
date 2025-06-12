import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/chat/logic/services/gemini_service.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:equatable/equatable.dart';
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(
    this.supabaseDatabaseService,
    this.geminiService,
    this.supabaseAuthService,
  ) : super(MessagesInitial());

  final SupabaseDatabaseService supabaseDatabaseService;
  final SupabaseAuthService supabaseAuthService;
  final GeminiService geminiService;

  bool isFirstMessageSent = false;
  bool isTopicCreated = false;
  String? currentChatId;
  String? currentMessage;

  Future<void> sendMessage({required String chatId, String? message}) async {
    try {
      await supabaseDatabaseService.addMessage(
        chatId: chatId,
        message: message,
        sender: AppStrings.user,
      );
      if (!isFirstMessageSent) {
        currentChatId = chatId;
        isFirstMessageSent = true;
      }
      currentMessage = message;
      emit(MessagesSuccess());
    } catch (e) {
      log('Error sending message: ${e.toString()}');
      emit(MessagesFailed());
    }
  }

  Future<void> getBotResponse({
    Future<void> Function({String? chatId, String? title})? createTopic,
  }) async {
    emit(MessagesLoading());
    try {
      final response = await geminiService.askGemini(prompt: currentMessage!);
      await supabaseDatabaseService.addMessage(
        chatId: currentChatId!,
        message: response[0],
        sender: AppStrings.bot,
      );
      if (!isTopicCreated) {
        await createTopic?.call(chatId: currentChatId, title: response[1]);
        isTopicCreated = true;
      }
      emit(MessagesSuccess());
    } catch (e) {
      log('Error getting bot response: ${e.toString()}');
      emit(MessagesFailed());
    }
  }
}
