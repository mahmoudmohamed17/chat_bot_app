import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/chat/logic/services/gemini_service.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
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

  bool isTopicCreated = false;

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

  Future<void> getBotResponse({
    required String chatId,
    String? message,
    Future<void> Function({
      String? chatId,
      String? userId,
      String? title,
      String? createdAt,
    })?
    createTopic,
  }) async {
    emit(MessagesLoading());
    try {
      final response = await geminiService.askGemini(prompt: message!);
      await supabaseDatabaseService.addMessage(
        chatId: chatId,
        message: response[0],
        sender: AppStrings.bot,
      );
      if (!isTopicCreated) {
        final now = DateTime.now();
        final time = DateFormat('EEEE, MMM d, yyyy').format(now);
        await createTopic?.call(
          chatId: chatId,
          userId: supabaseAuthService.currentUser!.id,
          title: response[1],
          createdAt: time,
        );
        isTopicCreated = true;
        log('Topic created with date: $time');
      }
      emit(MessagesSuccess());
    } catch (e) {
      emit(MessagesFailed());
    }
  }
}
