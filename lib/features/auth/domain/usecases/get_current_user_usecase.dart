import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/auth/domain/repositories/auth_repository.dart';
import 'package:what_2_eat/shared/domain/entities/user.dart';

class GetCurrentUserUseCase implements UseCase<User, NoParams> {
  GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<User> call(NoParams params) {
    return _repository.getCurrentUser();
  }
}
