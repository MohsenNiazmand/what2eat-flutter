import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/utils/repository_guard.dart';
import 'package:what_2_eat/features/favorites/data/models/favorite_model.dart';
import 'package:what_2_eat/features/favorites/data/services/favorite_api.dart';
import 'package:what_2_eat/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:what_2_eat/shared/data/mappers/entity_mappers.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl(this._favoriteApi);

  final FavoriteApi _favoriteApi;

  @override
  Future<Either<Failure, List<Favorite>>> listFavorites() {
    return guard(() async {
      final response = await _favoriteApi.listFavorites();
      return response.data.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Favorite>> addFavorite(String recipeId) {
    return guard(() async {
      final response = await _favoriteApi.addFavorite(
        AddFavoriteRequest(recipeId: recipeId),
      );
      return response.data.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String recipeId) {
    return guard(() async {
      await _favoriteApi.removeFavorite(recipeId);
    });
  }
}
