import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/auth/domain/repositories/auth_repository.dart';
import 'package:what_2_eat/shared/domain/entities/user.dart';

class UpdateProfileParams {
  const UpdateProfileParams({required this.name});

  final String name;
}

class UpdateProfileUseCase implements UseCase<User, UpdateProfileParams> {
  UpdateProfileUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<User> call(UpdateProfileParams params) {
    return _repository.updateProfile(params.name);
  }
}
