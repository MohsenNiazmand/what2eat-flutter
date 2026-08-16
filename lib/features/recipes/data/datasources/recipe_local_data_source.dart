import 'package:hive_ce/hive.dart';
import 'package:what_2_eat/core/error/exceptions.dart';
import 'package:what_2_eat/features/recipes/data/models/cached_recipe_list.dart';
import 'package:what_2_eat/shared/domain/entities/paginated_result.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

abstract class RecipeLocalDataSource {
  PaginatedResult<Recipe>? getCachedRecipes({
    String query = '',
    String? category,
  });

  Future<void> saveRecipes(
    List<Recipe> recipes, {
    String query = '',
    String? category,
    int currentPage = 1,
    int totalPages = 1,
    int limit = 20,
    int total = 0,
  });

  Future<void> addSingleRecipe(Recipe recipe);

  Future<void> saveRecipeById(Recipe recipe);

  Future<void> clearCache();

  Recipe? getCachedRecipeById(String id);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  RecipeLocalDataSourceImpl({
    required this.listCacheBox,
    required this.recipesByIdBox,
  });

  final Box<CachedRecipeList> listCacheBox;
  final Box<Recipe> recipesByIdBox;

  static String cacheKey({required String query, String? category}) {
    return '${query.trim()}|${category ?? ''}';
  }

  @override
  PaginatedResult<Recipe>? getCachedRecipes({
    String query = '',
    String? category,
  }) {
    try {
      final cached = listCacheBox.get(
        cacheKey(query: query, category: category),
      );
      if (cached == null) {
        return null;
      }

      return PaginatedResult(
        items: List<Recipe>.from(cached.recipes),
        pagination: Pagination(
          page: cached.currentPage,
          limit: cached.limit,
          total: cached.total,
          totalPages: cached.totalPages,
        ),
      );
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }

  @override
  Future<void> saveRecipes(
    List<Recipe> recipes, {
    String query = '',
    String? category,
    int currentPage = 1,
    int totalPages = 1,
    int limit = 20,
    int total = 0,
  }) async {
    try {
      await listCacheBox.put(
        cacheKey(query: query, category: category),
        CachedRecipeList(
          recipes: List<Recipe>.from(recipes),
          query: query,
          category: category,
          currentPage: currentPage,
          totalPages: totalPages,
          limit: limit,
          total: total,
        ),
      );

      for (final recipe in recipes) {
        await recipesByIdBox.put(recipe.id, recipe);
      }
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }

  @override
  Future<void> saveRecipeById(Recipe recipe) async {
    try {
      await recipesByIdBox.put(recipe.id, recipe);
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }

  @override
  Future<void> addSingleRecipe(Recipe recipe) async {
    try {
      await recipesByIdBox.put(recipe.id, recipe);

      final defaultKey = cacheKey(query: '', category: null);
      final cached = listCacheBox.get(defaultKey);
      if (cached == null) {
        return;
      }

      final isExisting = cached.recipes.any((item) => item.id == recipe.id);
      final updatedRecipes = [
        recipe,
        ...cached.recipes.where((item) => item.id != recipe.id),
      ];

      await listCacheBox.put(
        defaultKey,
        CachedRecipeList(
          recipes: updatedRecipes,
          query: cached.query,
          category: cached.category,
          currentPage: cached.currentPage,
          totalPages: cached.totalPages,
          limit: cached.limit,
          total: isExisting ? cached.total : cached.total + 1,
        ),
      );
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await listCacheBox.clear();
      await recipesByIdBox.clear();
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }

  @override
  Recipe? getCachedRecipeById(String id) {
    try {
      return recipesByIdBox.get(id);
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }
}
