import 'package:flutter/material.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class RecipeDetailContent extends StatelessWidget {
  const RecipeDetailContent({
    required this.recipe,
    super.key,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (recipe.category != null && recipe.category!.isNotEmpty) ...[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Chip(label: Text(recipe.category!)),
            ),
            const SizedBox(height: 12),
          ],
          if (recipe.description != null && recipe.description!.isNotEmpty) ...[
            Text(
              context.tr.descriptionSection,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              recipe.description!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
          ],
          _MetaRow(recipe: recipe),
          const SizedBox(height: 24),
          Text(
            context.tr.ingredientsSection,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          if (recipe.ingredients.isEmpty)
            Text(
              context.tr.noIngredients,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cTextSecondary,
                  ),
            )
          else
            ...recipe.ingredients.map(
              (ingredient) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.circle, size: 8),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: ingredient.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: ' — ${ingredient.amount}',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
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
          const SizedBox(height: 24),
          Text(
            context.tr.instructionsSection,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          if (recipe.instructions.isEmpty)
            Text(
              context.tr.noInstructions,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cTextSecondary,
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
                          radius: 14,
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          child: Text(
                            '${entry.key + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: Theme.of(context).textTheme.bodyLarge,
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
          label: context.tr.prepTimeLabel(recipe.prepTime!),
        ),
      );
    }
    if (recipe.cookTime != null) {
      items.add(
        _MetaChip(
          icon: Icons.local_fire_department_outlined,
          label: context.tr.cookTimeLabel(recipe.cookTime!),
        ),
      );
    }
    if (recipe.servings != null) {
      items.add(
        _MetaChip(
          icon: Icons.restaurant_outlined,
          label: context.tr.servingsCountLabel(recipe.servings!),
        ),
      );
    }
    if (recipe.calories != null) {
      items.add(
        _MetaChip(
          icon: Icons.local_dining_outlined,
          label: context.tr.caloriesLabel(recipe.calories!),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: cTextSecondary),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}
