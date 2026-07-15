import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/auth/domain/usecases/logout_usecase.dart';
import 'package:what_2_eat/features/auth/presentation/providers/auth_state_provider.dart';

part 'logout_provider.g.dart';

@riverpod
class LogoutNotifier extends _$LogoutNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<Failure?> logout() async {
    state = const AsyncValue.loading();

    final result = await getIt<LogoutUseCase>()(const NoParams());

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return failure;
      },
      (_) {
        ref.read(authStateProvider.notifier).setUnauthenticated();
        state = const AsyncValue.data(null);
        return null;
      },
    );
  }
}
