import 'package:what_2_eat/shared/domain/entities/ingredient.dart';

class Recipe {
  const Recipe({
    required this.id,
    required this.title,
    this.description,
    this.ingredients = const [],
    this.instructions = const [],
    this.category,
    this.prepTime,
    this.cookTime,
    this.servings,
    this.calories,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String title;
  final String? description;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final String? category;
  final int? prepTime;
  final int? cookTime;
  final int? servings;
  final int? calories;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
