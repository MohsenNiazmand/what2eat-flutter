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
    List<String>? countries,
    List<String>? dietaryPreferences,
    List<String>? ingredients,
    List<String>? tools,
    List<String>? exclusions,
    int? calorieLimit,
    int? servings,
    String? notes,
  }) {
    return guard(() async {
      final response = await _recipeApi.generateRecipe(
        GenerateRecipeRequest(
          countries: countries,
          dietaryPreferences: dietaryPreferences,
          ingredients: ingredients,
          tools: tools,
          exclusions: exclusions,
          calorieLimit: calorieLimit,
          servings: servings,
          notes: notes,
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
