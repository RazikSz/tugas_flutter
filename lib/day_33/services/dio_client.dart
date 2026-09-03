import 'dart:developer';

import 'package:dio/dio.dart';
import 'token_storage.dart';

Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://appabsensi.mobileprojp.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          final token = await TokenStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (e) {
          log("Dio onRequest token error: $e");
        }
        options.headers['Accept'] = 'application/json';
        log("Dio Request: [${options.method}] ${options.baseUrl}${options.path}");
        handler.next(options);
      },
      onError: (DioException e, handler) {
        log("Dio Error: ${e.response?.statusCode} -> ${e.response?.data}");
        handler.next(e);
      },
    ),
  );

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (obj) => log(obj.toString()),
  ));

  return dio;
}
