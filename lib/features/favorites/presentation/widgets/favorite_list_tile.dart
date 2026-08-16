import 'package:flutter/material.dart';
import 'package:what_2_eat/config/theme/app_radius.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/recipe_hero_image.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

class FavoriteListTile extends StatelessWidget {
  const FavoriteListTile({
    required this.favorite,
    required this.onTap,
    super.key,
  });

  final Favorite favorite;
  final VoidCallback onTap;

  static const BorderRadius _cardRadius =
      BorderRadius.all(Radius.circular(AppRadius.xl));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final recipe = favorite.recipe;
    final title = recipe?.title ?? context.tr.recipeDetailTitle;
    final category = recipe?.category;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: _cardRadius,
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: _cardRadius,
          child: InkWell(
            onTap: onTap,
            borderRadius: _cardRadius,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Row(
                children: [
                  RecipeListHeroThumbnail(
                    heroTag: favorite.recipeId,
                    imageUrl: recipe?.image,
                  ),
                  Gap.h16(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        if (category != null && category.isNotEmpty) ...[
                          Gap.v6(),
                          Text(
                            category,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cTextHint,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Gap.h8(),
                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.7,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
