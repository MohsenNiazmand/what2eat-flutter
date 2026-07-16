import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/shared/domain/entities/paginated_result.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, Recipe>> generateRecipe({
    List<String>? countries,
    List<String>? dietaryPreferences,
    List<String>? ingredients,
    List<String>? tools,
    List<String>? exclusions,
    int? calorieLimit,
    int? servings,
    String? notes,
  });

  Future<Either<Failure, PaginatedResult<Recipe>>> listRecipes({
    String? query,
    String? category,
    int? page,
    int? limit,
  });

  Future<Either<Failure, Recipe>> getRecipeById(String id);
}
