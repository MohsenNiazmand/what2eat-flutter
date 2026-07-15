import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/auth/domain/repositories/auth_repository.dart';

class RefreshTokenUseCase implements UseCase<void, NoParams> {
  RefreshTokenUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(NoParams params) {
    return _repository.refreshToken();
  }
}
