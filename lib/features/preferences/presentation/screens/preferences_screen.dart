import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/preferences/presentation/providers/preferences_providers.dart';
import 'package:what_2_eat/features/preferences/presentation/widgets/preference_chip_section.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';

class PreferencesScreen extends HookConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferencesAsync = ref.watch(preferencesLoadNotifierProvider);
    final saveState = ref.watch(savePreferencesNotifierProvider);
    final deleteState = ref.watch(deletePreferencesNotifierProvider);
    final selectedDietary = useState<Set<String>>({});
    final selectedCuisines = useState<Set<String>>({});
    final hasExistingPreferences = useState(false);
    final isBusy = saveState.isLoading || deleteState.isLoading;

    useEffect(
      () {
        preferencesAsync.whenData((preference) {
          if (preference == null) {
            hasExistingPreferences.value = false;
            selectedDietary.value = {};
            selectedCuisines.value = {};
            return;
          }

          hasExistingPreferences.value = true;
          selectedDietary.value = preference.dietaryRestrictions.toSet();
          selectedCuisines.value = preference.preferredCuisines.toSet();
        });
        return null;
      },
      [preferencesAsync],
    );

    Future<void> savePreferences() async {
      final failure = await ref
          .read(savePreferencesNotifierProvider.notifier)
          .save(
            dietaryRestrictions: selectedDietary.value.toList(),
            preferredCuisines: selectedCuisines.value.toList(),
          );

      if (!context.mounted) return;

      if (failure != null) {
        showFailureToast(failure);
        return;
      }

      hasExistingPreferences.value = true;
      showSuccessToast(context.tr.preferencesSavedSuccess);
    }

    Future<void> confirmDelete() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(context.tr.deletePreferencesTitle),
            content: Text(context.tr.deletePreferencesConfirmation),
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
          await ref.read(deletePreferencesNotifierProvider.notifier).delete();

      if (!context.mounted) return;

      if (failure != null) {
        showFailureToast(failure);
        return;
      }

      selectedDietary.value = {};
      selectedCuisines.value = {};
      hasExistingPreferences.value = false;
      showSuccessToast(context.tr.preferencesDeletedSuccess);
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.tr.preferencesTitle)),
      body: preferencesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          final message =
              error is Failure ? error.message : context.tr.errorTitle;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(preferencesLoadNotifierProvider);
                    },
                    child: Text(context.tr.retry),
                  ),
                ],
              ),
            ),
          );
        },
        data: (_) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.tr.preferencesSubtitle,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: cTextSecondary,
                                  ),
                        ),
                        if (!hasExistingPreferences.value) ...[
                          const SizedBox(height: 12),
                          Text(
                            context.tr.preferencesEmptyHint,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: cTextSecondary,
                                ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        PreferencesFormBody(
                          dietarySectionTitle:
                              context.tr.dietaryRestrictionsSection,
                          cuisineSectionTitle:
                              context.tr.preferredCuisinesSection,
                          selectedDietary: selectedDietary.value,
                          selectedCuisines: selectedCuisines.value,
                          onDietaryChanged: (value) {
                            selectedDietary.value = value;
                          },
                          onCuisinesChanged: (value) {
                            selectedCuisines.value = value;
                          },
                          enabled: !isBusy,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: isBusy ? null : savePreferences,
                        child: saveState.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(context.tr.savePreferences),
                      ),
                      if (hasExistingPreferences.value) ...[
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: isBusy ? null : confirmDelete,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: cError,
                            side: const BorderSide(color: cError),
                          ),
                          child: deleteState.isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(context.tr.deletePreferences),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
