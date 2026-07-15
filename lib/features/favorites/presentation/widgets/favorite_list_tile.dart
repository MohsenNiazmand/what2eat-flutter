import 'package:flutter/material.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

class FavoriteListTile extends StatelessWidget {
  const FavoriteListTile({
    required this.favorite,
    required this.onTap,
    super.key,
  });

  final Favorite favorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final recipe = favorite.recipe;
    final title = recipe?.title ?? context.tr.recipeDetailTitle;
    final category = recipe?.category;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: cError.withValues(alpha: 0.12),
          child: const Icon(Icons.favorite, color: cError),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: category != null && category.isNotEmpty
            ? Text(
                category,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: cTextSecondary,
                    ),
              )
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
