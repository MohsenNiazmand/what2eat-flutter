import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/exception_mapper.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/utils/repository_guard.dart';
import 'package:what_2_eat/features/recipes/data/datasources/recipe_local_data_source.dart';
import 'package:what_2_eat/features/recipes/data/models/generate_recipe_request.dart';
import 'package:what_2_eat/features/recipes/data/services/recipe_api.dart';
import 'package:what_2_eat/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:what_2_eat/shared/data/mappers/entity_mappers.dart';
import 'package:what_2_eat/shared/domain/entities/paginated_result.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  RecipeRepositoryImpl(this._recipeApi, this._localDataSource);

  final RecipeApi _recipeApi;
  final RecipeLocalDataSource _localDataSource;

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
      final recipe = response.data.toEntity();
      await _localDataSource.addSingleRecipe(recipe);
      return recipe;
    });
  }

  @override
  Future<Either<Failure, PaginatedResult<Recipe>>> listRecipes({
    String? query,
    String? category,
    int? page,
    int? limit,
  }) async {
    final normalizedQuery = query ?? '';
    final pageNumber = page ?? 1;
    final pageLimit = limit ?? 20;

    try {
      final response = await _recipeApi.listRecipes(
        query: query,
        category: category,
        page: pageNumber,
        limit: pageLimit,
      );

      final result = PaginatedResult(
        items: response.data.items.map((item) => item.toEntity()).toList(),
        pagination: response.data.pagination.toEntity(),
      );

      if (pageNumber == 1) {
        await _localDataSource.saveRecipes(
          result.items,
          query: normalizedQuery,
          category: category,
          currentPage: result.pagination.page,
          totalPages: result.pagination.totalPages,
          limit: result.pagination.limit,
          total: result.pagination.total,
        );
      } else {
        for (final recipe in result.items) {
          await _localDataSource.saveRecipeById(recipe);
        }
      }

      return Right(result);
    } on Object catch (error) {
      if (pageNumber == 1) {
        final cached = _localDataSource.getCachedRecipes(
          query: normalizedQuery,
          category: category,
        );
        if (cached != null) {
          return Right(cached);
        }
      }

      return Left(ExceptionMapper.mapException(error));
    }
  }

  @override
  Future<Either<Failure, Recipe>> getRecipeById(String id) async {
    final cached = _localDataSource.getCachedRecipeById(id);
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NotFoundFailure('Recipe not found'));
  }

  @override
  Recipe? getCachedRecipeById(String id) {
    return _localDataSource.getCachedRecipeById(id);
  }

  @override
  PaginatedResult<Recipe>? getCachedRecipes({
    String? query,
    String? category,
  }) {
    return _localDataSource.getCachedRecipes(
      query: query ?? '',
      category: category,
    );
  }
}
