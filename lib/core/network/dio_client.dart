import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:what_2_eat/core/constants/app_config.dart';

Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  if (AppConfig.isDev) {
    dio.interceptors.add(
      CurlLoggerDioInterceptor(printOnSuccess: true),
    );
  }

  return dio;
}
