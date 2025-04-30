import 'package:chat_bot_app/core/secret/api_strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: ApiStrings.supabaseProjectUrl,
    anonKey: ApiStrings.supabaseAnonKey,
  );
}
