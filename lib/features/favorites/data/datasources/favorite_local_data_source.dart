import 'package:hive_ce/hive.dart';
import 'package:what_2_eat/core/error/exceptions.dart';
import 'package:what_2_eat/features/favorites/data/models/cached_favorite_list.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

abstract class FavoriteLocalDataSource {
  List<Favorite>? getCachedFavorites();

  Future<void> saveFavorites(List<Favorite> favorites);

  Future<void> addFavorite(Favorite favorite);

  Future<void> removeFavorite(String recipeId);

  Future<void> clearCache();
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  FavoriteLocalDataSourceImpl({required this.cacheBox});

  static const cacheKey = 'favorites_list';

  final Box<CachedFavoriteList> cacheBox;

  @override
  List<Favorite>? getCachedFavorites() {
    try {
      final cached = cacheBox.get(cacheKey);
      if (cached == null) {
        return null;
      }
      return List<Favorite>.from(cached.favorites);
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }

  @override
  Future<void> saveFavorites(List<Favorite> favorites) async {
    try {
      await cacheBox.put(
        cacheKey,
        CachedFavoriteList(favorites: List<Favorite>.from(favorites)),
      );
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }

  @override
  Future<void> addFavorite(Favorite favorite) async {
    try {
      final current = getCachedFavorites() ?? const <Favorite>[];
      final updated = [
        favorite,
        ...current.where((item) => item.recipeId != favorite.recipeId),
      ];
      await saveFavorites(updated);
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }

  @override
  Future<void> removeFavorite(String recipeId) async {
    try {
      final current = getCachedFavorites();
      if (current == null) {
        return;
      }

      final updated =
          current.where((item) => item.recipeId != recipeId).toList();
      await saveFavorites(updated);
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await cacheBox.clear();
    } on Object catch (error) {
      throw CacheException(error.toString());
    }
  }
}
