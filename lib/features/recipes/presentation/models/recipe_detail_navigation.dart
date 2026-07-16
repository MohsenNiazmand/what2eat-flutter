import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class RecipeDetailNavigation {
  const RecipeDetailNavigation({
    required this.recipe,
    this.resolveFavoriteStatus = true,
  });

  const RecipeDetailNavigation.fromGenerate(this.recipe)
      : resolveFavoriteStatus = false;

  final Recipe recipe;
  final bool resolveFavoriteStatus;
}
