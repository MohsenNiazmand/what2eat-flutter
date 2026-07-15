import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/auth/presentation/providers/current_user_provider.dart';
import 'package:what_2_eat/features/auth/presentation/providers/logout_provider.dart';
import 'package:what_2_eat/features/profile/presentation/providers/profile_providers.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_loading_indicator.dart';

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
      body: user == null
          ? const AppLoadingIndicator()
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: cPrimary.withValues(alpha: 0.12),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        user.name?.isNotEmpty ?? false
                            ? user.name!
                            : context.tr.noDisplayName,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.mobileNumber,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: cTextSecondary,
                                ),
                      ),
                      const SizedBox(height: 32),
                      Card(
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          leading: const Icon(Icons.tune_outlined),
                          title: Text(context.tr.managePreferences),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: isBusy
                              ? null
                              : () => context.push(AppRoutes.preferences),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: nameController,
                        enabled: !isBusy,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: context.tr.displayNameLabel,
                          hintText: context.tr.displayNameHint,
                          prefixIcon: const Icon(Icons.badge_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return context.tr.displayNameRequired;
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => saveProfile(),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: isBusy ? null : saveProfile,
                        child: updateState.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(context.tr.saveProfile),
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: isBusy ? null : confirmLogout,
                        icon: logoutState.isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.logout),
                        label: Text(context.tr.logout),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: cError,
                          side: const BorderSide(color: cError),
                          minimumSize: const Size(double.infinity, 52),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
