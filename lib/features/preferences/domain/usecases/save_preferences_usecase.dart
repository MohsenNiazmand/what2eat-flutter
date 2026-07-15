import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/preferences/domain/repositories/preference_repository.dart';
import 'package:what_2_eat/shared/domain/entities/preference.dart';

class SavePreferencesParams {
  const SavePreferencesParams({
    required this.dietaryRestrictions,
    required this.preferredCuisines,
  });

  final List<String> dietaryRestrictions;
  final List<String> preferredCuisines;
}

class SavePreferencesUseCase
    implements UseCase<Preference, SavePreferencesParams> {
  SavePreferencesUseCase(this._repository);

  final PreferenceRepository _repository;

  @override
  ResultFuture<Preference> call(SavePreferencesParams params) {
    return _repository.upsertPreferences(
      dietaryRestrictions: params.dietaryRestrictions,
      preferredCuisines: params.preferredCuisines,
    );
  }
}
