import 'package:chat_bot_app/core/constants/app_strings.dart';
import 'package:chat_bot_app/core/networking/dio_service.dart';
import 'package:chat_bot_app/core/secret/api_strings.dart';

class GeminiService {
  final _dioService = DioService();

  Future<List<String>> askGemini({required String prompt}) async {
    final data =
        await _dioService.post(
              url: ApiStrings.geminiApiUrlPath,
              body: {
                "contents": [
                  {
                    "parts": [
                      {"text": AppStrings.geminiPrompt(prompt)},
                    ],
                  },
                ],
              },
              queryParameters: {"key": ApiStrings.geminiApiKey},
            )
            as Map<String, dynamic>;
    final response =
        data['candidates'][0]['content']['parts'][0]['text'] as String;
    final responseParts = response.split('\n\n${AppStrings.title}: ');
    final botAnswer = responseParts[0].trim();
    final chatTitle = responseParts[1].trim();
    return [botAnswer, chatTitle];
  }
}
