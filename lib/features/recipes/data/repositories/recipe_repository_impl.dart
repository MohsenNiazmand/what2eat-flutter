import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/utils/repository_guard.dart';
import 'package:what_2_eat/features/recipes/data/models/generate_recipe_request.dart';
import 'package:what_2_eat/features/recipes/data/services/recipe_api.dart';
import 'package:what_2_eat/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:what_2_eat/shared/data/mappers/entity_mappers.dart';
import 'package:what_2_eat/shared/domain/entities/paginated_result.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  RecipeRepositoryImpl(this._recipeApi);

  final RecipeApi _recipeApi;

  @override
  Future<Either<Failure, Recipe>> generateRecipe({
    required List<String> ingredients,
    List<String>? tools,
    int? calorieLimit,
    int? servings,
  }) {
    return guard(() async {
      final response = await _recipeApi.generateRecipe(
        GenerateRecipeRequest(
          ingredients: ingredients,
          tools: tools,
          calorieLimit: calorieLimit,
          servings: servings,
        ),
      );
      return response.data.toEntity();
    });
  }

  @override
  Future<Either<Failure, PaginatedResult<Recipe>>> listRecipes({
    String? query,
    String? category,
    int? page,
    int? limit,
  }) {
    return guard(() async {
      final response = await _recipeApi.listRecipes(
        query: query,
        category: category,
        page: page,
        limit: limit,
      );

      return PaginatedResult(
        items: response.data.items.map((e) => e.toEntity()).toList(),
        pagination: response.data.pagination.toEntity(),
      );
    });
  }

  @override
  Future<Either<Failure, Recipe>> getRecipeById(String id) {
    return guard(() async {
      final response = await _recipeApi.getRecipe(id);
      return response.data.toEntity();
    });
  }
}
