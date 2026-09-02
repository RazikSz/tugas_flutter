// Day 32: Dio HTTP Client Factory
import 'package:dio/dio.dart';

Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // LogInterceptor mencetak detail request dan response di console/debugger
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
}
