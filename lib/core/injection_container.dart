import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:what_2_eat/core/network/dio_client.dart';
import 'package:what_2_eat/core/storage/device_id_service.dart';
import 'package:what_2_eat/core/storage/secure_token_storage.dart';
import 'package:what_2_eat/core/storage/token_storage.dart';
import 'package:what_2_eat/features/auth/data/services/auth_api.dart';
import 'package:what_2_eat/features/favorites/data/services/favorite_api.dart';
import 'package:what_2_eat/features/preferences/data/services/preference_api.dart';
import 'package:what_2_eat/features/recipes/data/services/recipe_api.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt
    ..registerLazySingleton<Logger>(
      () => Logger(
        printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5),
      ),
    )
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<TokenStorage>(
      () => SecureTokenStorage(getIt()),
    )
    ..registerLazySingleton<DeviceIdService>(
      () => DeviceIdService(getIt()),
    )
    ..registerLazySingleton<Dio>(
      () => createDio(
        tokenStorage: getIt(),
        deviceIdService: getIt(),
      ),
    )
    ..registerLazySingleton<AuthApi>(() => AuthApi(getIt()))
    ..registerLazySingleton<RecipeApi>(() => RecipeApi(getIt()))
    ..registerLazySingleton<PreferenceApi>(() => PreferenceApi(getIt()))
    ..registerLazySingleton<FavoriteApi>(() => FavoriteApi(getIt()));
}
