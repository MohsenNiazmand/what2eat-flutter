import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/favorites/domain/usecases/list_favorites_usecase.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

part 'favorites_list_provider.g.dart';

@riverpod
class FavoritesListNotifier extends _$FavoritesListNotifier {
  @override
  Future<List<Favorite>> build() async {
    final result = await getIt<ListFavoritesUseCase>()(const NoParams());

    return result.fold(
      (failure) => throw StateError(failure.message),
      (favorites) => favorites,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Set<String> favoriteRecipeIds(FavoriteRecipeIdsRef ref) {
  final favoritesAsync = ref.watch(favoritesListNotifierProvider);

  return favoritesAsync.maybeWhen(
    data: (favorites) => favorites.map((favorite) => favorite.recipeId).toSet(),
    orElse: () => {},
  );
}
