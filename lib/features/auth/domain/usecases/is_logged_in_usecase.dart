import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/auth/domain/repositories/auth_repository.dart';

class IsLoggedInUseCase implements UseCase<bool, NoParams> {
  IsLoggedInUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final isLoggedIn = await _repository.isLoggedIn();
    return Right(isLoggedIn);
  }
}
