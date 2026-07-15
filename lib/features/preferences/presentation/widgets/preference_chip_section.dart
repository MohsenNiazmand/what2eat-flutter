import 'package:flutter/material.dart';
import 'package:what_2_eat/features/preferences/domain/constants/preference_options.dart';
import 'package:what_2_eat/features/preferences/presentation/utils/preference_labels.dart';

class PreferenceChipSection extends StatelessWidget {
  const PreferenceChipSection({
    required this.title,
    required this.options,
    required this.selectedValues,
    required this.onSelectionChanged,
    required this.labelBuilder,
    required this.enabled,
    super.key,
  });

  final String title;
  final List<PreferenceOption> options;
  final Set<String> selectedValues;
  final ValueChanged<Set<String>> onSelectionChanged;
  final String Function(String apiValue) labelBuilder;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
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
                label: Text(labelBuilder(option.apiValue)),
                selected: selectedValues.contains(option.apiValue),
                onSelected: enabled
                    ? (selected) {
                        final updated = Set<String>.from(selectedValues);
                        if (selected) {
                          updated.add(option.apiValue);
                        } else {
                          updated.remove(option.apiValue);
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

class PreferencesFormBody extends StatelessWidget {
  const PreferencesFormBody({
    required this.dietarySectionTitle,
    required this.cuisineSectionTitle,
    required this.selectedDietary,
    required this.selectedCuisines,
    required this.onDietaryChanged,
    required this.onCuisinesChanged,
    required this.enabled,
    super.key,
  });

  final String dietarySectionTitle;
  final String cuisineSectionTitle;
  final Set<String> selectedDietary;
  final Set<String> selectedCuisines;
  final ValueChanged<Set<String>> onDietaryChanged;
  final ValueChanged<Set<String>> onCuisinesChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    String dietaryLabel(String value) =>
        dietaryRestrictionLabel(context, value);
    String cuisineLabelFor(String value) => cuisineLabel(context, value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PreferenceChipSection(
          title: dietarySectionTitle,
          options: DietaryRestrictionOptions.all,
          selectedValues: selectedDietary,
          onSelectionChanged: onDietaryChanged,
          labelBuilder: dietaryLabel,
          enabled: enabled,
        ),
        const SizedBox(height: 28),
        PreferenceChipSection(
          title: cuisineSectionTitle,
          options: CuisineOptions.all,
          selectedValues: selectedCuisines,
          onSelectionChanged: onCuisinesChanged,
          labelBuilder: cuisineLabelFor,
          enabled: enabled,
        ),
      ],
    );
  }
}
