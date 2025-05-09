import 'package:bloc/bloc.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:equatable/equatable.dart';
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());
  final supabaseDatabaseService = SupabaseDatabaseService();

  Future<void> sendMessageFromUser() async {
    try {
      await supabaseDatabaseService.addMessage(
        chatId: 'd6b09b9b-c63f-426f-bb03-cb4c70d55f74',
        message: 'This message is from user!',
        sender: 'user',
      );
      emit(MessagesSuccess());
    } catch (e) {
      emit(MessagesFailed());
    }
  }

  Future<void> sendMessageFromBot() async {
    emit(MessagesLoading());
    try {
      await Future.delayed(const Duration(seconds: 5), () async {
        await supabaseDatabaseService.addMessage(
          chatId: 'd6b09b9b-c63f-426f-bb03-cb4c70d55f74',
          message: 'This message is from user!',
          sender: 'bot',
        );
      });
      emit(MessagesSuccess());
    } catch (e) {
      emit(MessagesFailed());
    }
  }
}
