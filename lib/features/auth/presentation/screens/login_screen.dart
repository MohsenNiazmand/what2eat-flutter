import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/constants/constants.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/auth/presentation/providers/login_provider.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_icon_badge.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_primary_button.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_text_field.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final mobileController = useTextEditingController();
    final loginState = ref.watch(loginNotifierProvider);
    final isLoading = loginState.isLoading;
    final theme = Theme.of(context);

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
                Gap.v24(),
                const Center(
                  child: AppIconBadge(icon: Icons.phone_android_rounded),
                ),
                Gap.v24(),
                Text(
                  context.tr.loginWithMobile,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),
                Gap.v8(),
                Text(
                  context.tr.loginSubtitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Gap.v32(),
                AppTextField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  textDirection: TextDirection.ltr,
                  labelText: context.tr.mobileNumberLabel,
                  hintText: context.tr.mobileNumberHint,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
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
                AppPrimaryButton(
                  label: context.tr.sendOtp,
                  isLoading: isLoading,
                  onPressed: submit,
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
