import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:what_2_eat/features/favorites/domain/usecases/remove_favorite_usecase.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';

part 'favorite_toggle_provider.g.dart';

@riverpod
class FavoriteToggleNotifier extends _$FavoriteToggleNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<Failure?> toggle({
    required String recipeId,
    required bool isCurrentlyFavorite,
  }) async {
    state = const AsyncValue.loading();

    final result = isCurrentlyFavorite
        ? await getIt<RemoveFavoriteUseCase>()(
            RemoveFavoriteParams(recipeId: recipeId),
          )
        : await getIt<AddFavoriteUseCase>()(
            AddFavoriteParams(recipeId: recipeId),
          );

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return failure;
      },
      (_) {
        if (isCurrentlyFavorite) {
          ref.read(favoriteRecipeIdsNotifierProvider.notifier).remove(recipeId);
        } else {
          ref.read(favoriteRecipeIdsNotifierProvider.notifier).add(recipeId);
        }
        ref.invalidate(favoritesListNotifierProvider);
        state = const AsyncValue.data(null);
        return null;
      },
    );
  }
}
