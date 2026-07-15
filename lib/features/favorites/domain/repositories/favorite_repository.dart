import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<Favorite>>> listFavorites();

  Future<Either<Failure, Favorite>> addFavorite(String recipeId);

  Future<Either<Failure, void>> removeFavorite(String recipeId);
}
