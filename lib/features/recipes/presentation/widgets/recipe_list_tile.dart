import 'package:flutter/material.dart';
import 'package:what_2_eat/config/theme/app_radius.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/core/utils/persian_digits.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/recipe_hero_image.dart';
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

  static const BorderRadius _cardRadius =
      BorderRadius.all(Radius.circular(AppRadius.xl));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final infoChips = _buildInfoChips(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    
                    children: [
                      RecipeListHeroThumbnail(
                        heroTag: recipe.id,
                        imageUrl: recipe.image,
                      ),
                      Gap.h16(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            if (recipe.category != null &&
                                recipe.category!.isNotEmpty) ...[
                              Gap.v6(),
                              Text(
                                recipe.category!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: cTextHint,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                            if (recipe.description != null &&
                                recipe.description!.isNotEmpty) ...[
                              Gap.v8(),
                              Text(
                                recipe.description!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                              ),
                            ],
                  
                          ],
                        ),
                      ),
                      Gap.h8(),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Icon(
                          Icons.chevron_right,
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                            if (infoChips.isNotEmpty) ...[
                              Gap.v12(),
                              Row(
                                
                                children: infoChips,
                              ),
                            ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInfoChips(BuildContext context) {
    final chips = <Widget>[];
    final totalMinutes = _totalMinutes();

    if (totalMinutes != null) {
      chips.add(
        _RecipeInfoChip(
          icon: Icons.schedule_outlined,
          label: PersianDigits.toPersian(
            context.tr.minutesShortLabel(totalMinutes),
          ),
        ),
      );

      final difficulty = _difficultyLabel(context, totalMinutes);
      if (difficulty != null) {
        chips.add(
          _RecipeInfoChip(
            icon: difficulty.icon,
            label: difficulty.label,
          ),
        );
      }
    }

    if (recipe.calories != null) {
      chips.add(
        _RecipeInfoChip(
          icon: Icons.local_fire_department_outlined,
          label: PersianDigits.toPersian(
            context.tr.caloriesShortLabel(recipe.calories!),
          ),
        ),
      );
    }

    return chips;
  }

  int? _totalMinutes() {
    final prep = recipe.prepTime;
    final cook = recipe.cookTime;
    if (prep == null && cook == null) {
      return null;
    }
    return (prep ?? 0) + (cook ?? 0);
  }

  ({String label, IconData icon})? _difficultyLabel(
    BuildContext context,
    int totalMinutes,
  ) {
    if (totalMinutes <= 30) {
      return (
        label: context.tr.difficultyEasy,
        icon: Icons.eco_outlined,
      );
    }
    if (totalMinutes <= 60) {
      return (
        label: context.tr.difficultyMedium,
        icon: Icons.local_fire_department_outlined,
      );
    }
    return (
      label: context.tr.difficultyHard,
      icon: Icons.whatshot_outlined,
    );
  }
}

class _RecipeInfoChip extends StatelessWidget {
  const _RecipeInfoChip({
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: cSurfaceElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cBorder.withValues(alpha: 0.75)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.primary),
          Gap.h4(),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
