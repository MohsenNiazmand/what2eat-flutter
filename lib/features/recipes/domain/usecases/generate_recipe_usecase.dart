import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class GenerateRecipeParams {
  const GenerateRecipeParams({
    required this.ingredients,
    this.tools,
    this.calorieLimit,
    this.servings,
  });

  final List<String> ingredients;
  final List<String>? tools;
  final int? calorieLimit;
  final int? servings;
}

class GenerateRecipeUseCase implements UseCase<Recipe, GenerateRecipeParams> {
  GenerateRecipeUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  ResultFuture<Recipe> call(GenerateRecipeParams params) {
    return _repository.generateRecipe(
      ingredients: params.ingredients,
      tools: params.tools,
      calorieLimit: params.calorieLimit,
      servings: params.servings,
    );
  }
}
