import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/auth/logic/repos/auth_repo.dart';
import 'package:chat_bot_app/auth/logic/repos/auth_repo_impl.dart';
import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/messages_cubit/messages_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
import 'package:chat_bot_app/chat/logic/services/gemini_service.dart';
import 'package:chat_bot_app/core/managers/users_cubit/users_cubit.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:chat_bot_app/core/services/supabase_database_service.dart';
import 'package:chat_bot_app/profile/logic/managers/mode_cubit/mode_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  /// Services
  getIt.registerLazySingleton<SupabaseAuthService>(() => SupabaseAuthService());
  getIt.registerLazySingleton<SupabaseDatabaseService>(
    () => SupabaseDatabaseService(),
  );
  getIt.registerLazySingleton<GeminiService>(() => GeminiService());

  /// Repos
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      supabaseAuthService: getIt(),
      supabaseDatabaseService: getIt(),
    ),
  );

  /// Cubits
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt()));
  getIt.registerLazySingleton<UsersCubit>(() => UsersCubit(getIt()));
  getIt.registerSingleton<ModeCubit>(ModeCubit());
  getIt.registerFactory<MessagesCubit>(
    () => MessagesCubit(getIt(), getIt(), getIt()),
  );

  getIt.registerLazySingleton<ChatsCubit>(() => ChatsCubit(getIt(), getIt()));
  getIt.registerLazySingleton<TopicsCubit>(() => TopicsCubit(getIt(), getIt()));
}

void registerMessageCubitForChat(String chatId) {
  if (!getIt.isRegistered<MessagesCubit>(instanceName: chatId)) {
    getIt.registerLazySingleton(() => MessagesCubit(getIt(), getIt(), getIt()));
  }
}

MessagesCubit getMessageCubitForChat(String chatId) {
  if (getIt.isRegistered<MessagesCubit>(instanceName: chatId)) {
    return getIt<MessagesCubit>(instanceName: chatId);
  }
  getIt.registerLazySingleton<MessagesCubit>(
    () => MessagesCubit(getIt(), getIt(), getIt()),
    instanceName: chatId,
  );
  return getIt<MessagesCubit>(instanceName: chatId);
}

void disposeMessageCubirForChat(String chatId) {
  if (getIt.isRegistered<MessagesCubit>(instanceName: chatId)) {
    getIt.unregister<MessagesCubit>(instanceName: chatId);
  }
}
