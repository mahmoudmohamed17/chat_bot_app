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

  Future<bool> checkUserExists(String userId) async {
    final user =
        await _client.from(usersTable).select().eq('user_id', userId).single();
    return user.isNotEmpty ? true : false;
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

  Future<void> deleteChat(String chatId) async {
    await _client.from(chatsTable).delete().eq('id', chatId);
  }

  Future<void> deleteAllChats() async {
    await _client.from(chatsTable).delete().gt('id', 0);
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

  Future<void> deleteChatMessages(String chatId) async {
    await _client.from(messagesTable).delete().eq('for_chat', chatId);
  }

  Future<void> deleteAllMessages() async {
    await _client.from(messagesTable).delete().gt('id', 0);
  }

  Stream messagesStream(String chatId) {
    return _client
        .from(messagesTable)
        .stream(primaryKey: ['id'])
        .eq('for_chat', chatId)
        .order('created_at', ascending: true);
  }

  Future<TopicModel> addTopic(String chatId, String userId) async {
    final data =
        await _client
            .from(topicsTable)
            .upsert({'for_chat': chatId, 'for_user': userId})
            .select()
            .single();
    final topic = TopicModel.fromJson(data);
    return topic;
  }

  Future<void> deleteTopic(String topicId) async {
    await _client.from(topicsTable).delete().eq('id', topicId);
  }

  Future<void> deleteAllTopics() async {
    await _client.from(topicsTable).delete().gt('id', 0);
  }

  Future<List<TopicModel>> getTopics(String userId) async {
    final data = await _client
        .from(topicsTable)
        .select()
        .eq('for_user', userId);
    final topics = data.map((topic) => TopicModel.fromJson(topic)).toList();
    return topics;
  }
}
