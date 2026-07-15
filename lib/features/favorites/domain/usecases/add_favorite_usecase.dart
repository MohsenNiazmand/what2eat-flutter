import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/favorites/domain/repositories/favorite_repository.dart';

class AddFavoriteParams {
  const AddFavoriteParams({required this.recipeId});

  final String recipeId;
}

class AddFavoriteUseCase implements UseCase<void, AddFavoriteParams> {
  AddFavoriteUseCase(this._repository);

  final FavoriteRepository _repository;

  @override
  ResultFuture<void> call(AddFavoriteParams params) async {
    final result = await _repository.addFavorite(params.recipeId);

    return result.fold(
      (failure) {
        if (failure is ConflictFailure) {
          return const Right(null);
        }
        return Left(failure);
      },
      (_) => const Right(null),
    );
  }
}
