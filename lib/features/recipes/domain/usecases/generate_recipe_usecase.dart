import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class GenerateRecipeParams {
  const GenerateRecipeParams({
    this.countries,
    this.dietaryPreferences,
    this.ingredients,
    this.tools,
    this.exclusions,
    this.calorieLimit,
    this.servings,
    this.notes,
  });

  final List<String>? countries;
  final List<String>? dietaryPreferences;
  final List<String>? ingredients;
  final List<String>? tools;
  final List<String>? exclusions;
  final int? calorieLimit;
  final int? servings;
  final String? notes;
}

class GenerateRecipeUseCase implements UseCase<Recipe, GenerateRecipeParams> {
  GenerateRecipeUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  ResultFuture<Recipe> call(GenerateRecipeParams params) {
    return _repository.generateRecipe(
      countries: params.countries,
      dietaryPreferences: params.dietaryPreferences,
      ingredients: params.ingredients,
      tools: params.tools,
      exclusions: params.exclusions,
      calorieLimit: params.calorieLimit,
      servings: params.servings,
      notes: params.notes,
    );
  }
}
