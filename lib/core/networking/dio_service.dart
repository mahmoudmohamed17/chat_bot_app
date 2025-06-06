import 'package:chat_bot_app/core/networking/dio_interceptor.dart';
import 'package:dio/dio.dart';

class DioService {
  final _dio = Dio();

  DioService() {
    _dio.interceptors.add(DioInterceptor());
  }

  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.post(
      url,
      data: body,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
