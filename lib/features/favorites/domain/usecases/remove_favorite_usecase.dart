import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/favorites/domain/repositories/favorite_repository.dart';

class RemoveFavoriteParams {
  const RemoveFavoriteParams({required this.recipeId});

  final String recipeId;
}

class RemoveFavoriteUseCase implements UseCase<void, RemoveFavoriteParams> {
  RemoveFavoriteUseCase(this._repository);

  final FavoriteRepository _repository;

  @override
  ResultFuture<void> call(RemoveFavoriteParams params) {
    return _repository.removeFavorite(params.recipeId);
  }
}
