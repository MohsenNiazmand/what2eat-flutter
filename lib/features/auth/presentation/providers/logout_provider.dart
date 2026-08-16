import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/auth/domain/usecases/logout_usecase.dart';
import 'package:what_2_eat/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:what_2_eat/features/favorites/data/datasources/favorite_local_data_source.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';
import 'package:what_2_eat/features/recipes/data/datasources/recipe_local_data_source.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_provider.dart';

part 'logout_provider.g.dart';

@riverpod
class LogoutNotifier extends _$LogoutNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<Failure?> logout() async {
    ref.read(authStateProvider.notifier).beginLogout();
    state = const AsyncValue.loading();

    try {
      final result = await getIt<LogoutUseCase>()(const NoParams());

      return await result.fold(
        (failure) async {
          state = AsyncValue.error(failure, StackTrace.current);
          return failure;
        },
        (_) async {
          await _clearLocalCaches();
          _resetCachedProviders();
          ref.read(authStateProvider.notifier).setUnauthenticated();
          state = const AsyncValue.data(null);
          return null;
        },
      );
    } finally {
      ref.read(authStateProvider.notifier).endLogout();
    }
  }

  Future<void> _clearLocalCaches() async {
    await getIt<RecipeLocalDataSource>().clearCache();
    await getIt<FavoriteLocalDataSource>().clearCache();
  }

  void _resetCachedProviders() {
    ref.invalidate(recipeListNotifierProvider);
    ref.invalidate(favoritesListNotifierProvider);
    ref.invalidate(favoriteRecipeIdsNotifierProvider);
  }
}
