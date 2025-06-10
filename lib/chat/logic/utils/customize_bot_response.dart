import 'package:chat_bot_app/core/constants/app_strings.dart';

List<String> customizeBotResponse(Map<String, dynamic> data) {
  final response =
      data['candidates'][0]['content']['parts'][0]['text'] as String;
  final responseParts = response.split('\n\n${AppStrings.title}: ');
  final botAnswer = responseParts[0].trim();
  final chatTitle = responseParts[1].trim();
  return [botAnswer, chatTitle];
}
