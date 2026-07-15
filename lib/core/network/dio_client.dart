import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:what_2_eat/core/constants/app_config.dart';
import 'package:what_2_eat/core/network/auth_interceptor.dart';
import 'package:what_2_eat/core/storage/device_id_service.dart';
import 'package:what_2_eat/core/storage/token_storage.dart';

Dio createDio({
  required TokenStorage tokenStorage,
  required DeviceIdService deviceIdService,
}) {
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

  dio.interceptors.add(
    AuthInterceptor(
      tokenStorage: tokenStorage,
      deviceIdService: deviceIdService,
      dio: dio,
    ),
  );

  if (AppConfig.isDev) {
    dio.interceptors.add(
      CurlLoggerDioInterceptor(printOnSuccess: true),
    );
  }

  return dio;
}
