import 'package:flutter/material.dart';
import 'package:what_2_eat/config/theme/app_radius.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/core/utils/persian_digits.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

class RecipeListTile extends StatelessWidget {
  const RecipeListTile({
    required this.recipe,
    required this.onTap,
    super.key,
  });

  final Recipe recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final subtitleParts = <String>[];

    if (recipe.category != null && recipe.category!.isNotEmpty) {
      subtitleParts.add(recipe.category!);
    }

    final totalTime = _formatTotalTime(context);
    if (totalTime != null) {
      subtitleParts.add(totalTime);
    }

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.restaurant_menu_rounded,
                  color: colorScheme.primary,
                ),
              ),
              Gap.h12(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: theme.textTheme.titleMedium,
                    ),
                    if (subtitleParts.isNotEmpty) ...[
                      Gap.v4(),
                      Text(
                        subtitleParts.join(' • '),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (recipe.description != null &&
                        recipe.description!.isNotEmpty) ...[
                      Gap.v4(),
                      Text(
                        recipe.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Gap.h8(),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _formatTotalTime(BuildContext context) {
    final prep = recipe.prepTime;
    final cook = recipe.cookTime;

    if (prep == null && cook == null) {
      return null;
    }

    final total = (prep ?? 0) + (cook ?? 0);
    return context.tr.totalTimeLabel(total).replaceAllMapped(
          RegExp(r'\d+'),
          (match) => PersianDigits.toPersian(match.group(0)!),
        );
  }
}
