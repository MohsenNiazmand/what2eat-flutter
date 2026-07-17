import 'package:flutter/material.dart';
import 'package:what_2_eat/config/theme/app_radius.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/core/utils/persian_digits.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

class RecipeDetailContent extends StatelessWidget {
  const RecipeDetailContent({
    required this.recipe,
    super.key,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (recipe.category != null && recipe.category!.isNotEmpty) ...[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Chip(
                label: Text(recipe.category!),
                backgroundColor: colorScheme.primaryContainer,
                side: BorderSide.none,
              ),
            ),
            Gap.v12(),
          ],
          if (recipe.description != null && recipe.description!.isNotEmpty) ...[
            Text(
              context.tr.descriptionSection,
              style: theme.textTheme.titleMedium,
            ),
            Gap.v8(),
            Text(
              recipe.description!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Gap.v24(),
          ],
          _MetaRow(recipe: recipe),
          Gap.v24(),
          Text(
            context.tr.ingredientsSection,
            style: theme.textTheme.titleLarge,
          ),
          Gap.v12(),
          if (recipe.ingredients.isEmpty)
            Text(
              context.tr.noIngredients,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            )
          else
            ...recipe.ingredients.map(
              (ingredient) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: colorScheme.primary,
                      ),
                    ),
                    Gap.h12(),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: ingredient.name,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  ' — ${PersianDigits.toPersian(ingredient.amount)}',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Gap.v24(),
          Text(
            context.tr.instructionsSection,
            style: theme.textTheme.titleLarge,
          ),
          Gap.v12(),
          if (recipe.instructions.isEmpty)
            Text(
              context.tr.noInstructions,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            )
          else
            ...recipe.instructions.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: colorScheme.primaryContainer,
                          child: Text(
                            PersianDigits.formatInt(entry.key + 1),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        Gap.h12(),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];

    if (recipe.prepTime != null) {
      items.add(
        _MetaChip(
          icon: Icons.schedule_outlined,
          label: PersianDigits.toPersian(
            context.tr.prepTimeLabel(recipe.prepTime!),
          ),
        ),
      );
    }
    if (recipe.cookTime != null) {
      items.add(
        _MetaChip(
          icon: Icons.local_fire_department_outlined,
          label: PersianDigits.toPersian(
            context.tr.cookTimeLabel(recipe.cookTime!),
          ),
        ),
      );
    }
    if (recipe.servings != null) {
      items.add(
        _MetaChip(
          icon: Icons.restaurant_outlined,
          label: PersianDigits.toPersian(
            context.tr.servingsCountLabel(recipe.servings!),
          ),
        ),
      );
    }
    if (recipe.calories != null) {
      items.add(
        _MetaChip(
          icon: Icons.local_dining_outlined,
          label: PersianDigits.toPersian(
            context.tr.caloriesLabel(recipe.calories!),
          ),
        ),
      );
    }

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items,
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: AppRadius.chip,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: colorScheme.primary),
          Gap.h8(),
          Text(label, style: theme.textTheme.labelLarge),
        ],
      ),
    );
  }
}
