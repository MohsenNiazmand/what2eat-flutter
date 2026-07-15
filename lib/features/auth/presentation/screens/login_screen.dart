import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/constants/constants.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/auth/presentation/providers/login_provider.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final mobileController = useTextEditingController();
    final loginState = ref.watch(loginNotifierProvider);
    final isLoading = loginState.isLoading;

    Future<void> submit() async {
      if (formKey.currentState?.validate() != true) return;

      final mobile = mobileController.text.trim();
      final failure = await ref.read(loginNotifierProvider.notifier).requestOtp(
            mobile,
          );

      if (!context.mounted) return;

      if (failure != null) {
        showFailureToast(context, failure);
        return;
      }

      showSuccessToast(context.tr.otpSentSuccess);
      await context.push('${AppRoutes.otpVerification}?mobile=$mobile');
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.tr.loginTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Icon(
                  Icons.phone_android,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  context.tr.loginWithMobile,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cTextPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr.loginSubtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: cTextSecondary,
                      ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  decoration: InputDecoration(
                    labelText: context.tr.mobileNumberLabel,
                    hintText: context.tr.mobileNumberHint,
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  validator: (value) {
                    final mobile = value?.trim() ?? '';
                    if (!Constants.mobileNumberPattern.hasMatch(mobile)) {
                      return context.tr.invalidMobileNumber;
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => submit(),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: isLoading ? null : submit,
                  child: isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(context.tr.sendOtp),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
