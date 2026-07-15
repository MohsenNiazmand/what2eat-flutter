import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:what_2_eat/shared/domain/entities/paginated_result.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class ListRecipesParams {
  const ListRecipesParams({
    this.query,
    this.category,
    this.page = 1,
    this.limit = 20,
  });

  final String? query;
  final String? category;
  final int page;
  final int limit;
}

class ListRecipesUseCase
    implements UseCase<PaginatedResult<Recipe>, ListRecipesParams> {
  ListRecipesUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  ResultFuture<PaginatedResult<Recipe>> call(ListRecipesParams params) {
    return _repository.listRecipes(
      query: params.query,
      category: params.category,
      page: params.page,
      limit: params.limit,
    );
  }
}
