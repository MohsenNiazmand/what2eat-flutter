import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';
import 'package:what_2_eat/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_provider.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

/// Cached recipe preview from list, favorites, or Hive — no network.
final recipePreviewProvider = Provider.family<Recipe?, String>((ref, id) {
  for (final recipe in ref.watch(recipeListNotifierProvider).items) {
    if (recipe.id == id) {
      return recipe;
    }
  }

  final favorites = ref.watch(favoritesListNotifierProvider).items;
  if (favorites.isNotEmpty) {
    for (final favorite in favorites) {
      if (favorite.recipeId == id && favorite.recipe != null) {
        return favorite.recipe;
      }
    }
  }

  return getIt<RecipeRepository>().getCachedRecipeById(id);
});

/// Favorite status from recipe data synced via list API — no GET /api/favorites.
final recipeIsFavoriteProvider = Provider.family<bool, String>((ref, recipeId) {
  final recipe = ref.watch(recipePreviewProvider(recipeId));
  if (recipe != null) {
    return recipe.isFavorite;
  }

  return ref.watch(favoriteRecipeIdsProvider).contains(recipeId);
});
