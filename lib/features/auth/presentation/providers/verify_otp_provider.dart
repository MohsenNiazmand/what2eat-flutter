import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:what_2_eat/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:what_2_eat/features/auth/presentation/providers/current_user_provider.dart';
import 'package:what_2_eat/shared/domain/entities/user.dart';

part 'verify_otp_provider.g.dart';

@riverpod
class VerifyOtpNotifier extends _$VerifyOtpNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<({Failure? failure, User? user})> verifyOtp({
    required String mobileNumber,
    required String otpCode,
  }) async {
    state = const AsyncValue.loading();

    final result = await getIt<VerifyOtpUseCase>()(
      VerifyOtpParams(mobileNumber: mobileNumber, otpCode: otpCode),
    );

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return (failure: failure, user: null);
      },
      (user) {
        ref.read(currentUserProvider.notifier).updateUser(user);
        ref.read(authStateProvider.notifier).setAuthenticated();
        state = const AsyncValue.data(null);
        return (failure: null, user: user);
      },
    );
  }
}
