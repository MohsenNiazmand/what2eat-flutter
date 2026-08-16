import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:what_2_eat/features/favorites/domain/usecases/list_favorites_usecase.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_state.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

part 'favorites_list_provider.g.dart';

@Riverpod(keepAlive: true)
class FavoriteRecipeIdsNotifier extends _$FavoriteRecipeIdsNotifier {
  @override
  Set<String> build() => {};

  void applyRecipeFavoriteFlags(Iterable<Recipe> recipes) {
    for (final recipe in recipes) {
      if (recipe.isFavorite) {
        state = {...state, recipe.id};
      } else {
        state = {...state}..remove(recipe.id);
      }
    }
  }

  void replaceAll(Set<String> ids) {
    state = ids;
  }

  void add(String recipeId) {
    state = {...state, recipeId};
  }

  void remove(String recipeId) {
    state = {...state}..remove(recipeId);
  }
}

@Riverpod(keepAlive: true)
class FavoritesListNotifier extends _$FavoritesListNotifier {
  late final ListFavoritesUseCase _listFavoritesUseCase;
  late final FavoriteRepository _favoriteRepository;

  @override
  FavoritesListUiState build() {
    _listFavoritesUseCase = getIt<ListFavoritesUseCase>();
    _favoriteRepository = getIt<FavoriteRepository>();

    final cached = _favoriteRepository.getCachedFavorites();
    if (cached != null) {
      _syncFavoriteIds(cached);
      Future.microtask(refresh);
      return FavoritesListUiState(items: cached);
    }

    Future.microtask(refresh);
    return const FavoritesListUiState(isLoadingInitial: true);
  }

  Future<void> refresh({bool showRefreshingIndicator = false}) async {
    final isSilent = !showRefreshingIndicator && state.items.isNotEmpty;

    if (showRefreshingIndicator) {
      state = state.copyWith(isRefreshing: true, clearFailure: true);
    } else if (!isSilent) {
      state = state.copyWith(isLoadingInitial: true, clearFailure: true);
    } else {
      state = state.copyWith(clearFailure: true);
    }

    final result = await _listFavoritesUseCase(const NoParams());

    result.fold(
      (failure) {
        if (isSilent && state.items.isNotEmpty) {
          state = state.copyWith(
            isLoadingInitial: false,
            isRefreshing: false,
          );
          return;
        }

        state = state.copyWith(
          failure: failure,
          isLoadingInitial: false,
          isRefreshing: false,
        );
      },
      (favorites) {
        _syncFavoriteIds(favorites);
        state = state.copyWith(
          items: favorites,
          isLoadingInitial: false,
          isRefreshing: false,
          clearFailure: true,
        );
      },
    );
  }

  void addLocally(Favorite favorite) {
    final updated = [
      favorite,
      ...state.items.where((item) => item.recipeId != favorite.recipeId),
    ];
    state = state.copyWith(items: updated, clearFailure: true);
    _syncFavoriteIds(updated);
  }

  void removeLocally(String recipeId) {
    final updated =
        state.items.where((item) => item.recipeId != recipeId).toList();
    state = state.copyWith(items: updated, clearFailure: true);
    ref.read(favoriteRecipeIdsNotifierProvider.notifier).remove(recipeId);
  }

  void _syncFavoriteIds(List<Favorite> favorites) {
    ref
        .read(favoriteRecipeIdsNotifierProvider.notifier)
        .replaceAll(favorites.map((favorite) => favorite.recipeId).toSet());
  }
}

@riverpod
Set<String> favoriteRecipeIds(FavoriteRecipeIdsRef ref) {
  return ref.watch(favoriteRecipeIdsNotifierProvider);
}
