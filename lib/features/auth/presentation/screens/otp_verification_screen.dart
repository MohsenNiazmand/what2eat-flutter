import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/constants/constants.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/core/utils/persian_digits.dart';
import 'package:what_2_eat/features/auth/presentation/providers/login_provider.dart';
import 'package:what_2_eat/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:what_2_eat/features/auth/presentation/widgets/otp_pin_field.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_primary_button.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

class OtpVerificationScreen extends HookConsumerWidget {
  const OtpVerificationScreen({
    required this.mobileNumber,
    super.key,
  });

  final String mobileNumber;

  static String _formatCountdown(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final formatted = '$minutes:${seconds.toString().padLeft(2, '0')}';
    return PersianDigits.toPersian(formatted);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpPinKey = useMemoized(GlobalKey<OtpPinFieldState>.new);
    final verifyState = ref.watch(verifyOtpNotifierProvider);
    final loginState = ref.watch(loginNotifierProvider);
    final isLoading = verifyState.isLoading || loginState.isLoading;
    final resendSecondsRemaining = useState(Constants.otpResendCooldownSeconds);
    final resendCooldownGeneration = useState(0);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final canResend = resendSecondsRemaining.value <= 0 && !isLoading;

    useEffect(
      () {
        if (!Constants.mobileNumberPattern.hasMatch(mobileNumber)) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.go(AppRoutes.login);
          });
        }
        return null;
      },
      [mobileNumber],
    );

    useEffect(
      () {
        if (resendSecondsRemaining.value <= 0) {
          return null;
        }

        final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (resendSecondsRemaining.value <= 1) {
            resendSecondsRemaining.value = 0;
            timer.cancel();
          } else {
            resendSecondsRemaining.value = resendSecondsRemaining.value - 1;
          }
        });

        return timer.cancel;
      },
      [resendCooldownGeneration.value],
    );

    void restartResendCooldown() {
      resendSecondsRemaining.value = Constants.otpResendCooldownSeconds;
      resendCooldownGeneration.value++;
    }

    Future<void> verify([String? otpCode]) async {
      final otp =
          (otpCode ?? otpPinKey.currentState?.otpText ?? '').trim();
      if (otp.length != Constants.otpLength) {
        showFailureToast(
          context,
          ValidationFailure(context.tr.otpInvalid),
        );
        return;
      }

      final result =
          await ref.read(verifyOtpNotifierProvider.notifier).verifyOtp(
                mobileNumber: mobileNumber,
                otpCode: otp,
              );

      if (!context.mounted) return;

      if (result.failure != null) {
        showFailureToast(context, result.failure!);
        return;
      }

      context.go(AppRoutes.home);
    }

    Future<void> resend() async {
      if (!canResend) return;

      final failure = await ref.read(loginNotifierProvider.notifier).requestOtp(
            mobileNumber,
          );

      if (!context.mounted) return;

      if (failure != null) {
        showFailureToast(context, failure);
        return;
      }

      otpPinKey.currentState?.restartSmsListener();
      restartResendCooldown();
      showSuccessToast(context.tr.otpSentSuccess);
    }

    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr.otpTitle),
          leading: BackButton(
            onPressed: () => context.go(AppRoutes.login),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gap.v24(),
                Text(
                  context.tr.otpSubtitle(PersianDigits.toPersian(mobileNumber)),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.7,
                  ),
                ),
                Gap.v32(),
                OtpPinField(
                  key: otpPinKey,
                  onCompleted: verify,
                ),
                Gap.v24(),
                if (resendSecondsRemaining.value > 0)
                  Text(
                    context.tr.resendOtpCountdown(
                      _formatCountdown(resendSecondsRemaining.value),
                    ),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  )
                else
                  TextButton(
                    onPressed: canResend ? resend : null,
                    child: Text(context.tr.resendOtp),
                  ),
                const Spacer(),
                AppPrimaryButton(
                  label: context.tr.verifyOtp,
                  isLoading: isLoading,
                  onPressed: () => verify(),
                ),
                Gap.v16(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
