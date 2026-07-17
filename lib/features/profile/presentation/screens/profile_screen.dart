import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/core/utils/persian_digits.dart';
import 'package:what_2_eat/features/auth/presentation/providers/current_user_provider.dart';
import 'package:what_2_eat/features/auth/presentation/providers/logout_provider.dart';
import 'package:what_2_eat/features/profile/presentation/providers/profile_providers.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_icon_badge.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_loading_indicator.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_outlined_button.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_primary_button.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_text_field.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final updateState = ref.watch(updateProfileNotifierProvider);
    final logoutState = ref.watch(logoutNotifierProvider);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController(text: user?.name ?? '');
    final isBusy = updateState.isLoading || logoutState.isLoading;
    final theme = Theme.of(context);

    useEffect(
      () {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          ref.read(profileRefreshNotifierProvider.notifier).refreshUser();
        });
        return null;
      },
      const [],
    );

    useEffect(
      () {
        nameController.text = user?.name ?? '';
        return null;
      },
      [user?.name],
    );

    Future<void> saveProfile() async {
      if (formKey.currentState?.validate() != true) return;

      final failure = await ref
          .read(updateProfileNotifierProvider.notifier)
          .updateProfile(nameController.text.trim());

      if (!context.mounted) return;

      if (failure != null) {
        showFailureToast(context, failure);
        return;
      }

      showSuccessToast(context.tr.profileUpdatedSuccess);
    }

    Future<void> confirmLogout() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(context.tr.logoutTitle),
            content: Text(context.tr.logoutConfirmation),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(context.tr.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(context.tr.confirm),
              ),
            ],
          );
        },
      );

      if (confirmed != true || !context.mounted) return;

      final failure =
          await ref.read(logoutNotifierProvider.notifier).logout();

      if (!context.mounted) return;

      if (failure != null) {
        showFailureToast(context, failure);
        return;
      }

      context.go(AppRoutes.login);
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.tr.profileTabTitle)),
      resizeToAvoidBottomInset: true,
      body: user == null
          ? const AppLoadingIndicator()
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        24,
                        24,
                        24,
                        24 + MediaQuery.viewInsetsOf(context).bottom,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Gap.v16(),
                            const Center(
                              child: AppIconBadge(icon: Icons.person_rounded),
                            ),
                            Gap.v24(),
                            Text(
                              user.name?.isNotEmpty ?? false
                                  ? user.name!
                                  : context.tr.noDisplayName,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall,
                            ),
                            Gap.v8(),
                            Text(
                              PersianDigits.toPersian(user.mobileNumber),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Gap.v32(),
                            AppTextField(
                              controller: nameController,
                              enabled: !isBusy,
                              textInputAction: TextInputAction.done,
                              labelText: context.tr.displayNameLabel,
                              hintText: context.tr.displayNameHint,
                              prefixIcon: const Icon(Icons.badge_outlined),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return context.tr.displayNameRequired;
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) => saveProfile(),
                            ),
                            Gap.v16(),
                            AppPrimaryButton(
                              label: context.tr.saveProfile,
                              isLoading: updateState.isLoading,
                              onPressed: isBusy ? null : saveProfile,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: AppOutlinedButton(
                      label: context.tr.logout,
                      icon: Icons.logout_rounded,
                      isLoading: logoutState.isLoading,
                      foregroundColor: theme.colorScheme.error,
                      onPressed: isBusy ? null : confirmLogout,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
