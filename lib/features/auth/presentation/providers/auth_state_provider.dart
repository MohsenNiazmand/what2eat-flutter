import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/core/usecase/usecase.dart';
import 'package:what_2_eat/features/auth/domain/enums/auth_status.dart';
import 'package:what_2_eat/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:what_2_eat/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:what_2_eat/features/auth/presentation/providers/current_user_provider.dart';

part 'auth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  AuthStatus build() => AuthStatus.initial;

  Future<void> checkSession() async {
    final result = await getIt<IsLoggedInUseCase>()(const NoParams());

    await result.fold(
      (_) async => state = AuthStatus.unauthenticated,
      (isLoggedIn) async {
        if (!isLoggedIn) {
          state = AuthStatus.unauthenticated;
          return;
        }

        final userResult =
            await getIt<GetCurrentUserUseCase>()(const NoParams());
        userResult.fold(
          (_) => state = AuthStatus.unauthenticated,
          (user) {
            ref.read(currentUserProvider.notifier).updateUser(user);
            state = AuthStatus.authenticated;
          },
        );
      },
    );
  }

  void setAuthenticated() {
    state = AuthStatus.authenticated;
  }

  void setUnauthenticated() {
    ref.read(currentUserProvider.notifier).clear();
    state = AuthStatus.unauthenticated;
  }
}
