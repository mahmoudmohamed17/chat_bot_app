import 'package:chat_bot_app/auth/logic/managers/cubit/auth_cubit.dart';
import 'package:chat_bot_app/auth/logic/repos/auth_repo.dart';
import 'package:chat_bot_app/auth/logic/repos/auth_repo_impl.dart';
import 'package:chat_bot_app/chat/logic/managers/chats_cubit/chats_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/messages_cubit/messages_cubit.dart';
import 'package:chat_bot_app/chat/logic/managers/topics_cubit/topics_cubit.dart';
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

  /// Repos
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      supabaseAuthService: getIt(),
      supabaseDatabaseService: getIt(),
    ),
  );

  /// Utils
  late ChatsCubit chatsCubit;
  late TopicsCubit topicsCubit;
  chatsCubit = ChatsCubit(getIt(), getIt(), null);
  topicsCubit = TopicsCubit(getIt(), chatsCubit);
  chatsCubit.topicsCubit = topicsCubit;

  /// Cubits
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt(), getIt()));
  getIt.registerFactory<UsersCubit>(() => UsersCubit(getIt()));
  getIt.registerFactory<ModeCubit>(() => ModeCubit());
  getIt.registerFactory<MessagesCubit>(() => MessagesCubit(getIt()));
  getIt.registerSingleton<ChatsCubit>(chatsCubit);
  getIt.registerSingleton<TopicsCubit>(topicsCubit);
}
