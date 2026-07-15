import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:what_2_eat/core/network/dio_client.dart';
import 'package:what_2_eat/core/storage/device_id_service.dart';
import 'package:what_2_eat/core/storage/secure_token_storage.dart';
import 'package:what_2_eat/core/storage/token_storage.dart';
import 'package:what_2_eat/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:what_2_eat/features/auth/data/services/auth_api.dart';
import 'package:what_2_eat/features/auth/domain/repositories/auth_repository.dart';
import 'package:what_2_eat/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:what_2_eat/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:what_2_eat/features/auth/domain/usecases/logout_usecase.dart';
import 'package:what_2_eat/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:what_2_eat/features/auth/domain/usecases/request_otp_usecase.dart';
import 'package:what_2_eat/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:what_2_eat/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:what_2_eat/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:what_2_eat/features/favorites/data/services/favorite_api.dart';
import 'package:what_2_eat/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:what_2_eat/features/preferences/data/repositories/preference_repository_impl.dart';
import 'package:what_2_eat/features/preferences/data/services/preference_api.dart';
import 'package:what_2_eat/features/preferences/domain/repositories/preference_repository.dart';
import 'package:what_2_eat/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:what_2_eat/features/recipes/data/services/recipe_api.dart';
import 'package:what_2_eat/features/recipes/domain/repositories/recipe_repository.dart';

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
    ..registerLazySingleton<FavoriteApi>(() => FavoriteApi(getIt()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authApi: getIt(),
        tokenStorage: getIt(),
        deviceIdService: getIt(),
      ),
    )
    ..registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<PreferenceRepository>(
      () => PreferenceRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<RequestOtpUseCase>(
      () => RequestOtpUseCase(getIt()),
    )
    ..registerLazySingleton<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(getIt()),
    )
    ..registerLazySingleton<RefreshTokenUseCase>(
      () => RefreshTokenUseCase(getIt()),
    )
    ..registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(getIt()),
    )
    ..registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(getIt()),
    )
    ..registerLazySingleton<IsLoggedInUseCase>(
      () => IsLoggedInUseCase(getIt()),
    )
    ..registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(getIt()),
    );
}
