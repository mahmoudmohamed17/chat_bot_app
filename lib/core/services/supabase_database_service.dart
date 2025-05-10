import 'package:chat_bot_app/core/constants/app_constants.dart';
import 'package:chat_bot_app/core/models/user_model.dart';
import 'package:chat_bot_app/history/logic/models/topic_model.dart';
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

  Future<String> createChat(String userId) async {
    final result =
        await _client
            .from(chatsTable)
            .upsert({'for_user': userId})
            .select()
            .single();
    return result['id'];
  }

  Future<void> addMessage({
    required String chatId,
    String? message,
    String? sender,
  }) async {
    await _client.from(messagesTable).upsert({
      'for_chat': chatId,
      'message': message,
      'sender': sender,
    });
  }

  Stream messagesStream(String chatId) {
    return _client
        .from(messagesTable)
        .stream(primaryKey: ['id'])
        .eq('for_chat', chatId)
        .order('created_at', ascending: true);
  }

  Future<void> addTopic(String chatId) async {
    await _client.from(topicsTable).upsert({'for_chat': chatId});
  }

  Future<void> deleteTopic(String topicId) async {
    await _client.from(topicsTable).delete().eq('id', topicId);
  }

  Future<List<TopicModel>> getTopics() async {
    final data = await _client.from(topicsTable).select();
    final topics = data.map((topic) => TopicModel.fromJson(topic)).toList();
    return topics;
  }
}
