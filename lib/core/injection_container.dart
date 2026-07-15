import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:what_2_eat/core/network/dio_client.dart';
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
    ..registerLazySingleton<Dio>(createDio)
    ..registerLazySingleton<AuthApi>(() => AuthApi(getIt()))
    ..registerLazySingleton<RecipeApi>(() => RecipeApi(getIt()))
    ..registerLazySingleton<PreferenceApi>(() => PreferenceApi(getIt()))
    ..registerLazySingleton<FavoriteApi>(() => FavoriteApi(getIt()));
}
