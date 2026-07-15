import 'package:flutter/material.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

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
    final subtitleParts = <String>[];

    if (recipe.category != null && recipe.category!.isNotEmpty) {
      subtitleParts.add(recipe.category!);
    }

    final totalTime = _formatTotalTime(context);
    if (totalTime != null) {
      subtitleParts.add(totalTime);
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: cPrimary.withValues(alpha: 0.12),
          child: Icon(
            Icons.restaurant_menu,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          recipe.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subtitleParts.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                subtitleParts.join(' • '),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: cTextSecondary,
                    ),
              ),
            ],
            if (recipe.description != null &&
                recipe.description!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                recipe.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
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
    return context.tr.totalTimeLabel(total);
  }
}
