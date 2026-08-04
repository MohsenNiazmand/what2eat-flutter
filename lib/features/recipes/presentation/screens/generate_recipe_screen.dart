import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/config/theme/app_radius.dart';
import 'package:what_2_eat/core/constants/app_assets.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/core/utils/persian_digits.dart';
import 'package:what_2_eat/core/utils/persian_input.dart';
import 'package:what_2_eat/features/auth/presentation/providers/current_user_provider.dart';
import 'package:what_2_eat/features/profile/presentation/providers/profile_providers.dart';
import 'package:what_2_eat/features/recipes/presentation/models/recipe_detail_navigation.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/generate_recipe_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/dynamic_text_field_list.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/recipe_option_chip_section.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_image_cover.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_loading_indicator.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_primary_button.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_text_field.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';
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
    final tools = useState<List<String>>(['']);
    final exclusions = useState<List<String>>(['']);
    final calorieController = useTextEditingController();
    final servingsController = useTextEditingController();
    final notesController = useTextEditingController();
    final moderationFailure = useState<ModerationFailure?>(null);
    final isGenerating = generateState.isLoading;
    final theme = Theme.of(context);
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
      final trimmed = PersianDigits.toLatin(value.trim());
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
            ingredients: ingredientList.isEmpty ? null : ingredientList,
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

      context.go(AppRoutes.home);
      await ref.read(recipeListNotifierProvider.notifier).refresh();

      if (!context.mounted) return;

      await context.push(
        AppRoutes.recipeDetailPath(recipe.id),
        extra: RecipeDetailNavigation.fromGenerate(recipe),
      );
    }

    final recipeOptions = user?.recipeOptions;

    if (user == null || recipeOptions == null) {
      return const Scaffold(
        body: SafeArea(
          bottom: false,
          child: AppLoadingIndicator(),
        ),
      );
    }

    final headerHeight = MediaQuery.sizeOf(context).width * 0.38;

    if (moderationFailure.value != null) {
      return Scaffold(
        body: SafeArea(
          bottom: false,
          child: ModerationWarningView(
            failure: moderationFailure.value!,
            onDismiss: () => moderationFailure.value = null,
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder: (context, _) {
                    return [
                      SliverAppBar(
                        expandedHeight: headerHeight,
                        toolbarHeight: 0,
                        collapsedHeight: 0,
                        primary: false,
                        pinned: false,
                        floating: false,
                        snap: false,
                        stretch: true,
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        forceMaterialTransparency: true,
                        flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.parallax,
                              stretchModes: const [
                                StretchMode.zoomBackground,
                              ],
                              background: Stack(
                                fit: StackFit.expand,
                                children: [
                                  const AppImageCover(
                                    assetPath: AppAssets.generationHeader,
                                  ),
                                  Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Color.lerp(
                                              Colors.black,
                                              cPrimaryDark,
                                              0.45,
                                            )!.withValues(alpha: 0.62),
                                          ],
                                          stops: const [0.35, 1],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.bottomStart,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        20,
                                        0,
                                        20,
                                        16,
                                      ),
                                      child: Text(
                                        context.tr.generateTabTitle,
                                        style: theme.textTheme.headlineSmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          shadows: const [
                                            Shadow(
                                              blurRadius: 10,
                                              color: Colors.black45,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ];
                      },
                      body: Theme(
                        data: theme.copyWith(
                          inputDecorationTheme:
                              _GenerateFormStyles.inputDecoration(theme),
                        ),
                        child: Opacity(
                          opacity: isGenerating ? 0.55 : 1,
                          child: IgnorePointer(
                            ignoring: isGenerating,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      24,
                                      16,
                                      24,
                                      0,
                                    ),
                                    child: Text(
                                      context.tr.generateSubtitle,
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                        height: 1.6,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        _GenerateSectionCard(
                                          child: RecipeOptionChipSection(
                                            title: context.tr.countriesSection,
                                            icon: Icons.public_rounded,
                                            options: recipeOptions.countries,
                                            selectedIds:
                                                selectedCountries.value,
                                            enabled: !isGenerating,
                                            onSelectionChanged: (value) {
                                              selectedCountries.value = value;
                                            },
                                          ),
                                        ),
                                        Gap.v16(),
                                        _GenerateSectionCard(
                                          child: RecipeOptionChipSection(
                                            title: context
                                                .tr.dietaryPreferencesSection,
                                            icon: Icons.eco_rounded,
                                            options:
                                                recipeOptions.dietaryPreferences,
                                            selectedIds: selectedDietary.value,
                                            enabled: !isGenerating,
                                            onSelectionChanged: (value) {
                                              selectedDietary.value = value;
                                            },
                                          ),
                                        ),
                                        Gap.v16(),
                                        _GenerateSectionCard(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              _GenerateSectionHeader(
                                                title: context
                                                    .tr.ingredientsSection,
                                                icon: Icons
                                                    .shopping_basket_outlined,
                                              ),
                                              Gap.v12(),
                                              DynamicTextFieldList(
                                                values: ingredients.value,
                                                enabled: !isGenerating,
                                                inputFormatters: [
                                                  persianFormatter,
                                                ],
                                                itemLabel: (index) => context.tr
                                                    .ingredientFieldLabel(
                                                  index + 1,
                                                ),
                                                itemHint:
                                                    context.tr.ingredientHint,
                                                addButtonLabel:
                                                    context.tr.addIngredient,
                                                onChanged: (index, value) {
                                                  final updated = [
                                                    ...ingredients.value,
                                                  ];
                                                  updated[index] = value;
                                                  ingredients.value = updated;
                                                },
                                                onAdd: () {
                                                  ingredients.value = [
                                                    ...ingredients.value,
                                                    '',
                                                  ];
                                                },
                                                onRemove: (index) {
                                                  if (ingredients.value.length <=
                                                      1) {
                                                    return;
                                                  }
                                                  final updated = [
                                                    ...ingredients.value,
                                                  ]..removeAt(index);
                                                  ingredients.value = updated;
                                                },
                                              ),
                                              Gap.v24(),
                                              _GenerateSectionHeader(
                                                title: context.tr.toolsSection,
                                                icon: Icons.handyman_outlined,
                                              ),
                                              Gap.v12(),
                                              DynamicTextFieldList(
                                                values: tools.value,
                                                enabled: !isGenerating,
                                                inputFormatters: [
                                                  persianFormatter,
                                                ],
                                                itemLabel: (index) => context.tr
                                                    .toolFieldLabel(index + 1),
                                                itemHint: context.tr.toolHint,
                                                addButtonLabel:
                                                    context.tr.addTool,
                                                onChanged: (index, value) {
                                                  final updated = [
                                                    ...tools.value,
                                                  ];
                                                  updated[index] = value;
                                                  tools.value = updated;
                                                },
                                                onAdd: () {
                                                  tools.value = [
                                                    ...tools.value,
                                                    '',
                                                  ];
                                                },
                                                onRemove: (index) {
                                                  if (tools.value.length <= 1) {
                                                    return;
                                                  }
                                                  final updated = [
                                                    ...tools.value,
                                                  ]..removeAt(index);
                                                  tools.value = updated;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Gap.v16(),
                                        _GenerateSectionCard(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              AppTextField(
                                                controller: calorieController,
                                                enabled: !isGenerating,
                                                keyboardType:
                                                    TextInputType.number,
                                                labelText:
                                                    context.tr.calorieLimitLabel,
                                                hintText:
                                                    context.tr.calorieLimitHint,
                                                prefixIcon: const Icon(
                                                  Icons.local_dining_outlined,
                                                ),
                                              ),
                                              Gap.v16(),
                                              AppTextField(
                                                controller: servingsController,
                                                enabled: !isGenerating,
                                                keyboardType:
                                                    TextInputType.number,
                                                labelText:
                                                    context.tr.servingsLabel,
                                                hintText:
                                                    context.tr.servingsHint,
                                                prefixIcon: const Icon(
                                                  Icons.restaurant_outlined,
                                                ),
                                              ),
                                              Gap.v24(),
                                              _GenerateSectionHeader(
                                                title:
                                                    context.tr.exclusionsSection,
                                                icon: Icons.block_outlined,
                                              ),
                                              Gap.v12(),
                                              DynamicTextFieldList(
                                                values: exclusions.value,
                                                enabled: !isGenerating,
                                                inputFormatters: [
                                                  persianFormatter,
                                                ],
                                                itemLabel: (index) => context.tr
                                                    .exclusionFieldLabel(
                                                  index + 1,
                                                ),
                                                itemHint:
                                                    context.tr.exclusionHint,
                                                addButtonLabel:
                                                    context.tr.addExclusion,
                                                onChanged: (index, value) {
                                                  final updated = [
                                                    ...exclusions.value,
                                                  ];
                                                  updated[index] = value;
                                                  exclusions.value = updated;
                                                },
                                                onAdd: () {
                                                  exclusions.value = [
                                                    ...exclusions.value,
                                                    '',
                                                  ];
                                                },
                                                onRemove: (index) {
                                                  if (exclusions.value.length <=
                                                      1) {
                                                    return;
                                                  }
                                                  final updated = [
                                                    ...exclusions.value,
                                                  ]..removeAt(index);
                                                  exclusions.value = updated;
                                                },
                                              ),
                                              Gap.v24(),
                                              AppTextField(
                                                controller: notesController,
                                                enabled: !isGenerating,
                                                maxLines: 3,
                                                inputFormatters: [
                                                  persianFormatter,
                                                ],
                                                labelText: context.tr.notesLabel,
                                                hintText: context.tr.notesHint,
                                                alignLabelWithHint: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: AppRadius.button,
                        boxShadow: [
                          BoxShadow(
                            color: cPrimary.withValues(alpha: 0.22),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: AppPrimaryButton(
                        label: isGenerating
                            ? context.tr.generatingRecipe
                            : context.tr.generateRecipeButton,
                        icon: Icons.auto_awesome_rounded,
                        isLoading: isGenerating,
                        onPressed: submit,
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

class _GenerateSectionCard extends StatelessWidget {
  const _GenerateSectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: cSurface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: cBorder.withValues(alpha: 0.85)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}

class _GenerateSectionHeader extends StatelessWidget {
  const _GenerateSectionHeader({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: theme.colorScheme.primary,
        ),
        Gap.h8(),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

abstract final class _GenerateFormStyles {
  static InputDecorationTheme inputDecoration(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return InputDecorationTheme(
      filled: true,
      fillColor: cSurfaceElevated,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: cBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: cBorder.withValues(alpha: 0.9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: colorScheme.primary.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
