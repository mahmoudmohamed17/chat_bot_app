import 'package:chat_bot_app/core/networking/dio_service.dart';
import 'package:chat_bot_app/core/secret/api_strings.dart';

class GeminiService {
  final _dioService = DioService();

  Future<String> askGemini({required String prompt}) async {
    final data =
        await _dioService.post(
              url: ApiStrings.geminiApiUrlPath,
              body: {
                "contents": [
                  {
                    "parts": [
                      {"text": prompt},
                    ],
                  },
                ],
              },
              queryParameters: {"key": ApiStrings.geminiApiKey},
            )
            as Map<String, dynamic>;
    final reponse =
        data['candidates'][0]['content']['parts'][0]['text'] as String;
    return reponse;
  }
}
