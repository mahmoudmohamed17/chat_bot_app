import 'package:chat_bot_app/auth/logic/repos/auth_repo.dart';
import 'package:chat_bot_app/auth/logic/repos/auth_repo_impl.dart';
import 'package:chat_bot_app/core/services/supabase_auth_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  /// Services
  getIt.registerLazySingleton<SupabaseAuthService>(() => SupabaseAuthService());

  /// Repos
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(supabaseAuthService: getIt()),
  );

  /// Cubits
  
}
