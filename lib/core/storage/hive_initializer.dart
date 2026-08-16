import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:what_2_eat/features/favorites/data/models/cached_favorite_list.dart';
import 'package:what_2_eat/features/recipes/data/models/cached_recipe_list.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';
import 'package:what_2_eat/shared/domain/entities/ingredient.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class HiveInitializer {
  HiveInitializer._();

  static const recipeListCacheBoxName = 'recipe_list_cache';
  static const recipesByIdBoxName = 'recipes_by_id';
  static const favoritesCacheBoxName = 'favorites_cache';

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(IngredientAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(RecipeAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(CachedRecipeListAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(FavoriteAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(CachedFavoriteListAdapter());
    }
  }

  static Future<Box<CachedRecipeList>> openRecipeListCacheBox() {
    return Hive.openBox<CachedRecipeList>(recipeListCacheBoxName);
  }

  static Future<Box<Recipe>> openRecipesByIdBox() {
    return Hive.openBox<Recipe>(recipesByIdBoxName);
  }

  static Future<Box<CachedFavoriteList>> openFavoritesCacheBox() {
    return Hive.openBox<CachedFavoriteList>(favoritesCacheBoxName);
  }
}
