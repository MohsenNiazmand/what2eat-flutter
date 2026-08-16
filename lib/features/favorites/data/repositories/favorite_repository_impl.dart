import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/exception_mapper.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/utils/repository_guard.dart';
import 'package:what_2_eat/features/favorites/data/datasources/favorite_local_data_source.dart';
import 'package:what_2_eat/features/favorites/data/models/favorite_model.dart';
import 'package:what_2_eat/features/favorites/data/services/favorite_api.dart';
import 'package:what_2_eat/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:what_2_eat/shared/data/mappers/entity_mappers.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl(this._favoriteApi, this._localDataSource);

  final FavoriteApi _favoriteApi;
  final FavoriteLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<Favorite>>> listFavorites() async {
    try {
      final response = await _favoriteApi.listFavorites();
      final favorites = response.data.map((item) => item.toEntity()).toList();
      await _localDataSource.saveFavorites(favorites);
      return Right(favorites);
    } on Object catch (error) {
      final cached = _localDataSource.getCachedFavorites();
      if (cached != null) {
        return Right(cached);
      }
      return Left(ExceptionMapper.mapException(error));
    }
  }

  @override
  List<Favorite>? getCachedFavorites() {
    return _localDataSource.getCachedFavorites();
  }

  @override
  Future<Either<Failure, Favorite>> addFavorite(String recipeId) {
    return guard(() async {
      final response = await _favoriteApi.addFavorite(
        AddFavoriteRequest(recipeId: recipeId),
      );
      final favorite = response.data.toEntity();
      await _localDataSource.addFavorite(favorite);
      return favorite;
    });
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String recipeId) {
    return guard(() async {
      await _favoriteApi.removeFavorite(recipeId);
      await _localDataSource.removeFavorite(recipeId);
    });
  }
}
