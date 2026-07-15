import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:what_2_eat/config/router/go_router_provider.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/storage/device_id_service.dart';
import 'package:what_2_eat/core/storage/token_storage.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required this._tokenStorage,
    required this._deviceIdService,
    required Dio dio,
  })  : _dio = dio,
        _refreshDio = Dio(
          BaseOptions(
            baseUrl: dio.options.baseUrl,
            connectTimeout: dio.options.connectTimeout,
            receiveTimeout: dio.options.receiveTimeout,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

  final TokenStorage _tokenStorage;
  final DeviceIdService _deviceIdService;
  final Dio _dio;
  final Dio _refreshDio;

  static Future<bool>? _refreshFuture;

  static const _authExemptPaths = {
    '/api/auth/otp/request',
    '/api/auth/otp/verify',
    '/api/auth/refresh',
    '/health',
  };

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_isAuthExempt(options.path)) {
      final accessToken = await _tokenStorage.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final shouldRefresh = statusCode == 401 &&
        !_isAuthExempt(err.requestOptions.path) &&
        err.requestOptions.extra['_retried'] != true;

    if (!shouldRefresh) {
      handler.next(err);
      return;
    }

    final refreshed = await _tryRefreshToken();
    if (!refreshed) {
      await _handleSessionExpired();
      handler.next(err);
      return;
    }

    try {
      final accessToken = await _tokenStorage.getAccessToken();
      final requestOptions = err.requestOptions;
      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
      requestOptions.extra['_retried'] = true;

      final response = await _dio.fetch<dynamic>(requestOptions);
      handler.resolve(response);
    } on DioException catch (retryError) {
      if (retryError.response?.statusCode == 401) {
        await _handleSessionExpired();
      }
      handler.next(retryError);
    }
  }

  Future<bool> _tryRefreshToken() async {
    if (_refreshFuture != null) {
      return _refreshFuture!;
    }

    _refreshFuture = _performRefresh();
    try {
      return await _refreshFuture!;
    } finally {
      _refreshFuture = null;
    }
  }

  Future<bool> _performRefresh() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      final deviceId = await _deviceIdService.getDeviceId();
      final response = await _refreshDio.post<Map<String, dynamic>>(
        '/api/auth/refresh',
        data: {
          'refreshToken': refreshToken,
          'deviceId': deviceId,
        },
      );

      final accessToken = response.data?['accessToken'] as String?;
      if (accessToken == null || accessToken.isEmpty) {
        return false;
      }

      await _tokenStorage.saveAccessToken(accessToken);
      return true;
    } on DioException {
      return false;
    }
  }

  Future<void> _handleSessionExpired() async {
    await _tokenStorage.clearTokens();
    _redirectToLogin();
  }

  void _redirectToLogin() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final context = rootNavigatorKey.currentContext;
      if (context == null || !context.mounted) return;

      final location = GoRouter.of(context)
          .routerDelegate
          .currentConfiguration
          .uri
          .path;

      if (location != AppRoutes.login) {
        context.go(AppRoutes.login);
      }
    });
  }

  bool _isAuthExempt(String path) {
    return _authExemptPaths.contains(path);
  }
}
