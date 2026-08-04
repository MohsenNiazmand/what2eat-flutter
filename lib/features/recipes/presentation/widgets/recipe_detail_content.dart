import 'package:flutter/material.dart';
import 'package:what_2_eat/config/theme/app_radius.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/core/utils/persian_digits.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

final RegExp _leadingStepNumberPattern =
    RegExp(r'^[۰-۹0-9]+[\.\-\s]+');

String _sanitizeInstructionText(String instruction) {
  return instruction.replaceFirst(_leadingStepNumberPattern, '').trim();
}

class RecipeDetailContent extends StatelessWidget {
  const RecipeDetailContent({
    required this.recipe,
    super.key,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (recipe.category != null && recipe.category!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: _CategoryTag(label: recipe.category!),
              ),
            ),
          Text(
            recipe.title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: cTextPrimary,
              height: 1.25,
              letterSpacing: 0.3,
            ),
          ),
          if (recipe.description != null && recipe.description!.isNotEmpty) ...[
            Gap.v12(),
            Text(
              recipe.description!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: cTextSecondary,
                fontSize: 16,
                height: 1.85,
                letterSpacing: 0.25,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
          Gap.v24(),
          _MetaRow(recipe: recipe),
          Gap.v24(),
          _SectionTitle(title: context.tr.ingredientsSection),
          Gap.v16(),
          if (recipe.ingredients.isEmpty)
            Text(
              context.tr.noIngredients,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cTextHint,
                height: 1.6,
              ),
            )
          else
            ...recipe.ingredients.map(
              (ingredient) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: cPrimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Gap.h12(),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: ingredient.name,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: cTextPrimary,
                            height: 1.6,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  ' — ${PersianDigits.toPersian(ingredient.amount)}',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: cTextHint,
                                height: 1.6,
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
          _SectionTitle(title: context.tr.instructionsSection),
          Gap.v16(),
          if (recipe.instructions.isEmpty)
            Text(
              context.tr.noInstructions,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cTextHint,
                height: 1.6,
              ),
            )
          else
            ...recipe.instructions.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [cPrimaryLight, cPrimary],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: cPrimary.withValues(alpha: 0.22),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            PersianDigits.formatInt(entry.key + 1),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Gap.h16(),
                        Expanded(
                          child: Text(
                            _sanitizeInstructionText(entry.value),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: cTextPrimary,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              letterSpacing: 0.1,
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

class _CategoryTag extends StatelessWidget {
  const _CategoryTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: cSurfaceElevated.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: cBorder.withValues(alpha: 0.75),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: cPrimary.withValues(alpha: 0.88),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.35,
          height: 1.2,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: cTextPrimary,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.recipe});

  final Recipe recipe;

  int? get _totalTimeMinutes {
    final prep = recipe.prepTime;
    final cook = recipe.cookTime;
    if (prep != null && cook != null) return prep + cook;
    return prep ?? cook;
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];

    final totalTime = _totalTimeMinutes;
    if (totalTime != null) {
      items.add(
        _MetaChip(
          icon: Icons.schedule_rounded,
          label: PersianDigits.toPersian(
            context.tr.minutesShortLabel(totalTime),
          ),
        ),
      );
    }
    if (recipe.servings != null) {
      items.add(
        _MetaChip(
          icon: Icons.restaurant_rounded,
          label: PersianDigits.toPersian(
            context.tr.servingsCountLabel(recipe.servings!),
          ),
        ),
      );
    }
    if (recipe.calories != null) {
      items.add(
        _MetaChip(
          icon: Icons.local_fire_department_rounded,
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
      spacing: 10,
      runSpacing: 10,
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: cSurface,
        borderRadius: AppRadius.chip,
        border: Border.all(
          color: cBorder.withValues(alpha: 0.65),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 17,
            color: cPrimary.withValues(alpha: 0.92),
          ),
          Gap.h8(),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: cTextPrimary,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
