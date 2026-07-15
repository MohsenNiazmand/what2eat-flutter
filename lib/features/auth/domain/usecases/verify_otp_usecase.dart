import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/auth/domain/repositories/auth_repository.dart';
import 'package:what_2_eat/shared/domain/entities/user.dart';

class VerifyOtpParams {
  const VerifyOtpParams({
    required this.mobileNumber,
    required this.otpCode,
  });

  final String mobileNumber;
  final String otpCode;
}

class VerifyOtpUseCase implements UseCase<User, VerifyOtpParams> {
  VerifyOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<User> call(VerifyOtpParams params) {
    return _repository.verifyOtp(
      mobileNumber: params.mobileNumber,
      otpCode: params.otpCode,
    );
  }
}
