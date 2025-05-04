import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseService {
  final _client = Supabase.instance.client;

  Future<Map<String, dynamic>> getUser(UserModel user) async {
    return await _client
        .from(usersTable)
        .select()
        .eq('user_id', user.userId!)
        .limit(1)
        .single();
  }

  Future<void> addUser(UserModel user) async {
    await _client.from(usersTable).insert(user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    await _client.from(usersTable).update(user.toJson());
  }

  Future<void> deleteUser(UserModel user) async {
    await _client.from(usersTable).delete().eq('user_id', user.userId!);
  }
}
