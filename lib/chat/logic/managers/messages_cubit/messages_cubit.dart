import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:equatable/equatable.dart';
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this.supabaseDatabaseService) : super(MessagesInitial());
  final SupabaseDatabaseService supabaseDatabaseService;

  /// TODO: use Gemini Service here

  Future<void> sendMessageFromUser({
    required String chatId,
    String? message,
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

  Future<void> sendMessageFromBot({
    required String chatId,
    String? message,
  }) async {
    emit(MessagesLoading());
    try {
      /// TODO: taking reponse from Gemini and add it to stream
      await Future.delayed(const Duration(seconds: 5), () async {
        await supabaseDatabaseService.addMessage(
          chatId: chatId,
          message: message,
          sender: AppStrings.bot,
        );
      });
      emit(MessagesSuccess());
    } catch (e) {
      emit(MessagesFailed());
    }
  }
}
