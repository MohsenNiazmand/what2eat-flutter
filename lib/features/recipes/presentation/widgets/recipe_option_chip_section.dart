import 'package:flutter/material.dart';
import 'package:what_2_eat/shared/domain/entities/recipe_options.dart';

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

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final option in options)
              FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(option.label),
                    if (!option.isAvailable) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.lock_outline,
                        size: 16,
                        color: Theme.of(context).disabledColor,
                      ),
                    ],
                  ],
                ),
                selected: selectedIds.contains(option.id),
                onSelected: enabled && option.isAvailable
                    ? (selected) {
                        final updated = Set<String>.from(selectedIds);
                        if (selected) {
                          updated.add(option.id);
                        } else {
                          updated.remove(option.id);
                        }
                        onSelectionChanged(updated);
                      }
                    : null,
              ),
          ],
        ),
      ],
    );
  }
}
