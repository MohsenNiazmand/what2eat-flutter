import 'package:hive_ce/hive.dart';
import 'package:what_2_eat/shared/domain/entities/ingredient.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
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
    this.isFavorite = false,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final List<Ingredient> ingredients;

  @HiveField(4)
  final List<String> instructions;

  @HiveField(5)
  final String? category;

  @HiveField(6)
  final int? prepTime;

  @HiveField(7)
  final int? cookTime;

  @HiveField(8)
  final int? servings;

  @HiveField(9)
  final int? calories;

  @HiveField(10)
  final String? image;

  @HiveField(11)
  final DateTime? createdAt;

  @HiveField(12)
  final DateTime? updatedAt;

  @HiveField(13)
  final bool isFavorite;

  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    List<Ingredient>? ingredients,
    List<String>? instructions,
    String? category,
    int? prepTime,
    int? cookTime,
    int? servings,
    int? calories,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      category: category ?? this.category,
      prepTime: prepTime ?? this.prepTime,
      cookTime: cookTime ?? this.cookTime,
      servings: servings ?? this.servings,
      calories: calories ?? this.calories,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
