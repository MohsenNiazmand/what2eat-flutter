import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_provider.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

/// Cached recipe preview from list or favorites for instant detail navigation.
final recipePreviewProvider = Provider.family<Recipe?, String>((ref, id) {
  for (final recipe in ref.watch(recipeListNotifierProvider).items) {
    if (recipe.id == id) {
      return recipe;
    }
  }

  final favorites = ref.watch(favoritesListNotifierProvider).valueOrNull;
  if (favorites == null) {
    return null;
  }

  for (final favorite in favorites) {
    if (favorite.recipeId == id) {
      return favorite.recipe;
    }
  }

  return null;
});
