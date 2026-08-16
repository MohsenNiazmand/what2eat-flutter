import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_preview_provider.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

part 'recipe_detail_provider.g.dart';

@riverpod
Future<Recipe> recipeDetail(RecipeDetailRef ref, String id) async {
  final recipe = ref.watch(recipePreviewProvider(id));
  if (recipe != null) {
    return recipe;
  }

  throw StateError('Recipe not found locally');
}
