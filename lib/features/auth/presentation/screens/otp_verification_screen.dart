import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/config/theme/app_radius.dart';
import 'package:what_2_eat/core/constants/constants.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/core/utils/persian_digits.dart';
import 'package:what_2_eat/features/auth/presentation/providers/login_provider.dart';
import 'package:what_2_eat/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_primary_button.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

class OtpVerificationScreen extends HookConsumerWidget {
  const OtpVerificationScreen({
    required this.mobileNumber,
    super.key,
  });

  final String mobileNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinController = useTextEditingController();
    final verifyState = ref.watch(verifyOtpNotifierProvider);
    final loginState = ref.watch(loginNotifierProvider);
    final isLoading = verifyState.isLoading || loginState.isLoading;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 56,
      textStyle: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outline),
        borderRadius: AppRadius.input,
      ),
    );

    Future<void> verify() async {
      final otp = pinController.text.trim();
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
      final failure = await ref.read(loginNotifierProvider.notifier).requestOtp(
            mobileNumber,
          );

      if (!context.mounted) return;

      if (failure != null) {
        showFailureToast(context, failure);
        return;
      }

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
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: pinController,
                    length: Constants.otpLength,
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration?.copyWith(
                        border: Border.all(
                          color: colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    onCompleted: (_) => verify(),
                  ),
                ),
                Gap.v24(),
                TextButton(
                  onPressed: isLoading ? null : resend,
                  child: Text(context.tr.resendOtp),
                ),
                const Spacer(),
                AppPrimaryButton(
                  label: context.tr.verifyOtp,
                  isLoading: isLoading,
                  onPressed: verify,
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
