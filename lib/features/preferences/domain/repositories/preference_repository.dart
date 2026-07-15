import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/shared/domain/entities/preference.dart';

abstract class PreferenceRepository {
  Future<Either<Failure, Preference>> getPreferences();

  Future<Either<Failure, Preference>> upsertPreferences({
    required List<String> dietaryRestrictions,
    required List<String> preferredCuisines,
  });

  Future<Either<Failure, void>> deletePreferences();
}
