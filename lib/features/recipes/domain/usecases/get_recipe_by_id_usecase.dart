import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class GetRecipeByIdParams {
  const GetRecipeByIdParams({required this.id});

  final String id;
}

class GetRecipeByIdUseCase implements UseCase<Recipe, GetRecipeByIdParams> {
  GetRecipeByIdUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  ResultFuture<Recipe> call(GetRecipeByIdParams params) {
    return _repository.getRecipeById(params.id);
  }
}
