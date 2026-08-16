import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:what_2_eat/features/favorites/domain/usecases/remove_favorite_usecase.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_provider.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

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

    if (isCurrentlyFavorite) {
      final result = await getIt<RemoveFavoriteUseCase>()(
        RemoveFavoriteParams(recipeId: recipeId),
      );

      return result.fold(
        (failure) {
          state = AsyncValue.error(failure, StackTrace.current);
          return failure;
        },
        (_) {
          _applyFavoriteChange(recipeId: recipeId, isFavorite: false);
          state = const AsyncValue.data(null);
          return null;
        },
      );
    }

    final result = await getIt<AddFavoriteUseCase>()(
      AddFavoriteParams(recipeId: recipeId),
    );

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return failure;
      },
      (favorite) {
        _applyFavoriteChange(
          recipeId: recipeId,
          isFavorite: true,
          favorite: favorite,
        );
        state = const AsyncValue.data(null);
        return null;
      },
    );
  }

  void _applyFavoriteChange({
    required String recipeId,
    required bool isFavorite,
    Favorite? favorite,
  }) {
    if (isFavorite) {
      ref.read(favoriteRecipeIdsNotifierProvider.notifier).add(recipeId);
      if (favorite != null) {
        ref.read(favoritesListNotifierProvider.notifier).addLocally(favorite);
      }
    } else {
      ref.read(favoriteRecipeIdsNotifierProvider.notifier).remove(recipeId);
      ref.read(favoritesListNotifierProvider.notifier).removeLocally(recipeId);
    }

    ref.read(recipeListNotifierProvider.notifier).updateRecipeFavoriteStatus(
          recipeId,
          isFavorite: isFavorite,
        );
  }
}
