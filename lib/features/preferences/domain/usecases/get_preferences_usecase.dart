import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/preferences/domain/repositories/preference_repository.dart';
import 'package:what_2_eat/shared/domain/entities/preference.dart';

class GetPreferencesUseCase implements UseCase<Preference?, NoParams> {
  GetPreferencesUseCase(this._repository);

  final PreferenceRepository _repository;

  @override
  ResultFuture<Preference?> call(NoParams params) async {
    final result = await _repository.getPreferences();

    return result.fold(
      (failure) {
        if (failure is NotFoundFailure) {
          return const Right(null);
        }
        return Left(failure);
      },
      Right.new,
    );
  }
}
