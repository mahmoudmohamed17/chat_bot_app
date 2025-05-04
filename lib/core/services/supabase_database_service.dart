import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService {
  final _client = Supabase.instance.client;

  Future<UserModel?> getUser(String userId) async {
    final data =
        await _client.from(usersTable).select().eq('user_id', userId).single();
    return UserModel.fromJson(data);
  }

  Future<void> addUser(UserModel user) async {
    await _client.from(usersTable).upsert(user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    await _client
        .from(usersTable)
        .update(user.toJson())
        .eq('user_id', user.userId!);
  }

  Future<void> deleteUser(String userId) async {
    await _client.from(usersTable).delete().eq('user_id', userId);
  }
}
