import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

abstract class UseCase<T, Params> {
  ResultFuture<T> call(Params params);
}

class NoParams {
  const NoParams();
}
