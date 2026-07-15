import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

class ListFavoritesUseCase implements UseCase<List<Favorite>, NoParams> {
  ListFavoritesUseCase(this._repository);

  final FavoriteRepository _repository;

  @override
  ResultFuture<List<Favorite>> call(NoParams params) {
    return _repository.listFavorites();
  }
}
