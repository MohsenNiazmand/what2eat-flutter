import 'package:fpdart/fpdart.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/shared/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> requestOtp(String mobileNumber);

  Future<Either<Failure, User>> verifyOtp({
    required String mobileNumber,
    required String otpCode,
  });

  Future<Either<Failure, void>> refreshToken();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, User>> updateProfile(String name);

  Future<bool> isLoggedIn();
}
