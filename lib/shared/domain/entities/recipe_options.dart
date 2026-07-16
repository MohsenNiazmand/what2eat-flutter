class RecipeOptionItem {
  const RecipeOptionItem({
    required this.id,
    required this.label,
    required this.isAvailable,
  });

  final String id;
  final String label;
  final bool isAvailable;
}

class RecipeOptions {
  const RecipeOptions({
    required this.countries,
    required this.dietaryPreferences,
  });

  final List<RecipeOptionItem> countries;
  final List<RecipeOptionItem> dietaryPreferences;
}
