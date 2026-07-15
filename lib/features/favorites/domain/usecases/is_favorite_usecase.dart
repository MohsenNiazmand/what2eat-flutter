import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/favorites/domain/repositories/favorite_repository.dart';

class IsFavoriteParams {
  const IsFavoriteParams({required this.recipeId});

  final String recipeId;
}

class IsFavoriteUseCase implements UseCase<bool, IsFavoriteParams> {
  IsFavoriteUseCase(this._repository);

  final FavoriteRepository _repository;

  @override
  ResultFuture<bool> call(IsFavoriteParams params) async {
    final result = await _repository.listFavorites();

    return result.map(
      (favorites) =>
          favorites.any((favorite) => favorite.recipeId == params.recipeId),
    );
  }
}
