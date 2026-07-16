import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/favorites/domain/usecases/list_favorites_usecase.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

part 'favorites_list_provider.g.dart';

@Riverpod(keepAlive: true)
class FavoriteRecipeIdsNotifier extends _$FavoriteRecipeIdsNotifier {
  bool _loaded = false;

  @override
  Set<String> build() => {};

  Future<void> loadIfNeeded() async {
    if (_loaded) return;

    final result = await getIt<ListFavoritesUseCase>()(const NoParams());

    result.fold(
      (_) {},
      (favorites) {
        _loaded = true;
        state = favorites.map((favorite) => favorite.recipeId).toSet();
      },
    );
  }

  void replaceAll(Set<String> ids) {
    _loaded = true;
    state = ids;
  }

  void add(String recipeId) {
    state = {...state, recipeId};
  }

  void remove(String recipeId) {
    state = {...state}..remove(recipeId);
  }
}

@riverpod
class FavoritesListNotifier extends _$FavoritesListNotifier {
  @override
  Future<List<Favorite>> build() async {
    final result = await getIt<ListFavoritesUseCase>()(const NoParams());

    return result.fold(
      (failure) => throw StateError(failure.message),
      (favorites) {
        ref
            .read(favoriteRecipeIdsNotifierProvider.notifier)
            .replaceAll(favorites.map((favorite) => favorite.recipeId).toSet());
        return favorites;
      },
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Set<String> favoriteRecipeIds(FavoriteRecipeIdsRef ref) {
  return ref.watch(favoriteRecipeIdsNotifierProvider);
}
