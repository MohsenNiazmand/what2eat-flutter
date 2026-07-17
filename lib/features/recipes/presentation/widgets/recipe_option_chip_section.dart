import 'package:flutter/material.dart';
import 'package:what_2_eat/shared/domain/entities/recipe_options.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

class RecipeOptionChipSection extends StatelessWidget {
  const RecipeOptionChipSection({
    required this.title,
    required this.options,
    required this.selectedIds,
    required this.onSelectionChanged,
    required this.enabled,
    super.key,
  });

  final String title;
  final List<RecipeOptionItem> options;
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onSelectionChanged;
  final bool enabled;

  static List<RecipeOptionItem> sortedOptions(List<RecipeOptionItem> options) {
    final available = options.where((option) => option.isAvailable).toList();
    final locked = options.where((option) => !option.isAvailable).toList();
    return [...available, ...locked];
  }

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final sorted = sortedOptions(options);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        Gap.v12(),
        SizedBox(
          height: 52,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: sorted.length,
            separatorBuilder: (_, __) => Gap.h8(),
            itemBuilder: (context, index) {
              final option = sorted[index];
              final selected = selectedIds.contains(option.id);

              return AnimatedScale(
                scale: selected ? 1.02 : 1,
                duration: const Duration(milliseconds: 160),
                child: FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(option.label),
                      if (!option.isAvailable) ...[
                        Gap.h4(),
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 16,
                          color: theme.disabledColor,
                        ),
                      ],
                    ],
                  ),
                  selected: selected,
                  onSelected: enabled && option.isAvailable
                      ? (isSelected) {
                          final updated = Set<String>.from(selectedIds);
                          if (isSelected) {
                            updated.add(option.id);
                          } else {
                            updated.remove(option.id);
                          }
                          onSelectionChanged(updated);
                        }
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
