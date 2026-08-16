import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

class AddFavoriteParams {
  const AddFavoriteParams({required this.recipeId});

  final String recipeId;
}

class AddFavoriteUseCase implements UseCase<Favorite, AddFavoriteParams> {
  AddFavoriteUseCase(this._repository);

  final FavoriteRepository _repository;

  @override
  ResultFuture<Favorite> call(AddFavoriteParams params) async {
    final result = await _repository.addFavorite(params.recipeId);

    return result.fold(
      (failure) {
        if (failure is ConflictFailure) {
          return Right(
            Favorite(
              id: params.recipeId,
              recipeId: params.recipeId,
              createdAt: DateTime.now(),
            ),
          );
        }
        return Left(failure);
      },
      Right.new,
    );
  }
}
