import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/preferences/domain/repositories/preference_repository.dart';

class DeletePreferencesUseCase implements UseCase<void, NoParams> {
  DeletePreferencesUseCase(this._repository);

  final PreferenceRepository _repository;

  @override
  ResultFuture<void> call(NoParams params) {
    return _repository.deletePreferences();
  }
}
