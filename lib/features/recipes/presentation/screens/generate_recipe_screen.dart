import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/core/utils/persian_input.dart';
import 'package:what_2_eat/features/auth/presentation/providers/current_user_provider.dart';
import 'package:what_2_eat/features/profile/presentation/providers/profile_providers.dart';
import 'package:what_2_eat/features/recipes/presentation/models/recipe_detail_navigation.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/generate_recipe_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/dynamic_text_field_list.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/recipe_option_chip_section.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_loading_indicator.dart';
import 'package:what_2_eat/shared/presentation/widgets/moderation_warning_view.dart';

class GenerateRecipeScreen extends HookConsumerWidget {
  const GenerateRecipeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final generateState = ref.watch(generateRecipeNotifierProvider);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final selectedCountries = useState<Set<String>>({});
    final selectedDietary = useState<Set<String>>({});
    final ingredients = useState<List<String>>(['']);
    final tools = useState<List<String>>([]);
    final exclusions = useState<List<String>>([]);
    final calorieController = useTextEditingController();
    final servingsController = useTextEditingController();
    final notesController = useTextEditingController();
    final moderationFailure = useState<ModerationFailure?>(null);
    final isGenerating = generateState.isLoading;
    final persianFormatter = useMemoized(
      () => createPersianTextFormatter(
        onRejected: () => showMessageToast(context.tr.persianOnlyAllowed),
      ),
    );

    useEffect(
      () {
        if (user?.recipeOptions != null) return null;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          ref.read(profileRefreshNotifierProvider.notifier).refreshUser();
        });
        return null;
      },
      [user?.recipeOptions],
    );

    int? parseOptionalInt(String value) {
      final trimmed = value.trim();
      if (trimmed.isEmpty) return null;
      return int.tryParse(trimmed);
    }

    List<String> nonEmptyValues(List<String> values) {
      return values
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList();
    }

    bool hasInvalidPersianText(List<String> values) {
      for (final value in values) {
        final trimmed = value.trim();
        if (trimmed.isEmpty) continue;
        if (!isValidPersianText(trimmed)) {
          return true;
        }
      }
      return false;
    }

    bool hasAtLeastOneConstraint({
      required List<String> ingredientList,
      required int? calorieLimit,
      required int? servings,
      required String notes,
    }) {
      return selectedCountries.value.isNotEmpty ||
          selectedDietary.value.isNotEmpty ||
          ingredientList.isNotEmpty ||
          calorieLimit != null ||
          servings != null ||
          notes.trim().isNotEmpty;
    }

    Future<void> submit() async {
      moderationFailure.value = null;

      if (formKey.currentState?.validate() != true) return;

      final ingredientList = nonEmptyValues(ingredients.value);
      final toolList = nonEmptyValues(tools.value);
      final exclusionList = nonEmptyValues(exclusions.value);
      final notes = notesController.text.trim();
      final calorieLimit = parseOptionalInt(calorieController.text);
      final servings = parseOptionalInt(servingsController.text);

      if (hasInvalidPersianText(ingredients.value) ||
          hasInvalidPersianText(tools.value) ||
          hasInvalidPersianText(exclusions.value) ||
          (notes.isNotEmpty && !isValidPersianText(notes))) {
        showFailureToast(
          context,
          ValidationFailure(context.tr.persianOnlyAllowed),
        );
        return;
      }

      if (!hasAtLeastOneConstraint(
        ingredientList: ingredientList,
        calorieLimit: calorieLimit,
        servings: servings,
        notes: notes,
      )) {
        showFailureToast(
          context,
          ValidationFailure(context.tr.generateConstraintRequired),
        );
        return;
      }

      if (calorieController.text.trim().isNotEmpty && calorieLimit == null) {
        showFailureToast(context, ValidationFailure(context.tr.invalidNumber));
        return;
      }

      if (servingsController.text.trim().isNotEmpty && servings == null) {
        showFailureToast(context, ValidationFailure(context.tr.invalidNumber));
        return;
      }

      final recipe = await ref
          .read(generateRecipeNotifierProvider.notifier)
          .generate(
            countries: selectedCountries.value.isEmpty
                ? null
                : selectedCountries.value.toList(),
            dietaryPreferences: selectedDietary.value.isEmpty
                ? null
                : selectedDietary.value.toList(),
            ingredients:
                ingredientList.isEmpty ? null : ingredientList,
            tools: toolList.isEmpty ? null : toolList,
            exclusions: exclusionList.isEmpty ? null : exclusionList,
            calorieLimit: calorieLimit,
            servings: servings,
            notes: notes.isEmpty ? null : notes,
          );

      if (!context.mounted) return;

      if (recipe == null) {
        final failure =
            ref.read(generateRecipeNotifierProvider.notifier).lastFailure;
        if (failure is ModerationFailure) {
          moderationFailure.value = failure;
          return;
        }
        if (failure != null) {
          showFailureToast(context, failure);
        }
        return;
      }

      await context.push(
        AppRoutes.recipeDetailPath(recipe.id),
        extra: RecipeDetailNavigation.fromGenerate(recipe),
      );
    }

    final recipeOptions = user?.recipeOptions;

    if (user == null || recipeOptions == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.tr.generateTabTitle)),
        body: const AppLoadingIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.tr.generateTabTitle)),
      body: SafeArea(
        child: moderationFailure.value != null
            ? ModerationWarningView(
                failure: moderationFailure.value!,
                onDismiss: () => moderationFailure.value = null,
              )
            : Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              context.tr.generateSubtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: cTextSecondary),
                            ),
                            const SizedBox(height: 24),
                            RecipeOptionChipSection(
                              title: context.tr.countriesSection,
                              options: recipeOptions.countries,
                              selectedIds: selectedCountries.value,
                              enabled: !isGenerating,
                              onSelectionChanged: (value) {
                                selectedCountries.value = value;
                              },
                            ),
                            const SizedBox(height: 24),
                            RecipeOptionChipSection(
                              title: context.tr.dietaryPreferencesSection,
                              options: recipeOptions.dietaryPreferences,
                              selectedIds: selectedDietary.value,
                              enabled: !isGenerating,
                              onSelectionChanged: (value) {
                                selectedDietary.value = value;
                              },
                            ),
                            const SizedBox(height: 24),
                            Text(
                              context.tr.ingredientsSection,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            DynamicTextFieldList(
                              values: ingredients.value,
                              enabled: !isGenerating,
                              inputFormatters: [persianFormatter],
                              itemLabel: (index) =>
                                  context.tr.ingredientFieldLabel(index + 1),
                              itemHint: context.tr.ingredientHint,
                              addButtonLabel: context.tr.addIngredient,
                              onChanged: (index, value) {
                                final updated = [...ingredients.value];
                                updated[index] = value;
                                ingredients.value = updated;
                              },
                              onAdd: () {
                                ingredients.value = [...ingredients.value, ''];
                              },
                              onRemove: (index) {
                                if (ingredients.value.length <= 1) return;
                                final updated = [...ingredients.value]
                                  ..removeAt(index);
                                ingredients.value = updated;
                              },
                            ),
                            const SizedBox(height: 24),
                            Text(
                              context.tr.toolsSection,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            DynamicTextFieldList(
                              values: tools.value.isEmpty ? [''] : tools.value,
                              enabled: !isGenerating,
                              minItems: 0,
                              inputFormatters: [persianFormatter],
                              itemLabel: (index) =>
                                  context.tr.toolFieldLabel(index + 1),
                              itemHint: context.tr.toolHint,
                              addButtonLabel: context.tr.addTool,
                              onChanged: (index, value) {
                                final current = tools.value.isEmpty
                                    ? ['']
                                    : [...tools.value];
                                current[index] = value;
                                tools.value = current;
                              },
                              onAdd: () {
                                final current = tools.value.isEmpty
                                    ? ['']
                                    : [...tools.value];
                                tools.value = [...current, ''];
                              },
                              onRemove: (index) {
                                final current = [...tools.value]
                                  ..removeAt(index);
                                tools.value = current;
                              },
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: calorieController,
                              enabled: !isGenerating,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: context.tr.calorieLimitLabel,
                                hintText: context.tr.calorieLimitHint,
                                prefixIcon:
                                    const Icon(Icons.local_dining_outlined),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: servingsController,
                              enabled: !isGenerating,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: context.tr.servingsLabel,
                                hintText: context.tr.servingsHint,
                                prefixIcon:
                                    const Icon(Icons.restaurant_outlined),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              context.tr.exclusionsSection,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            DynamicTextFieldList(
                              values: exclusions.value.isEmpty
                                  ? ['']
                                  : exclusions.value,
                              enabled: !isGenerating,
                              minItems: 0,
                              inputFormatters: [persianFormatter],
                              itemLabel: (index) =>
                                  context.tr.exclusionFieldLabel(index + 1),
                              itemHint: context.tr.exclusionHint,
                              addButtonLabel: context.tr.addExclusion,
                              onChanged: (index, value) {
                                final current = exclusions.value.isEmpty
                                    ? ['']
                                    : [...exclusions.value];
                                current[index] = value;
                                exclusions.value = current;
                              },
                              onAdd: () {
                                final current = exclusions.value.isEmpty
                                    ? ['']
                                    : [...exclusions.value];
                                exclusions.value = [...current, ''];
                              },
                              onRemove: (index) {
                                final current = [...exclusions.value]
                                  ..removeAt(index);
                                exclusions.value = current;
                              },
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: notesController,
                              enabled: !isGenerating,
                              maxLines: 3,
                              inputFormatters: [persianFormatter],
                              decoration: InputDecoration(
                                labelText: context.tr.notesLabel,
                                hintText: context.tr.notesHint,
                                alignLabelWithHint: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      child: ElevatedButton.icon(
                        onPressed: isGenerating ? null : submit,
                        icon: isGenerating
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.auto_awesome),
                        label: Text(
                          isGenerating
                              ? context.tr.generatingRecipe
                              : context.tr.generateRecipeButton,
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 52),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
