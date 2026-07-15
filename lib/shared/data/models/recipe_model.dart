import 'package:json_annotation/json_annotation.dart';
import 'package:what_2_eat/shared/data/models/ingredient_model.dart';

part 'recipe_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RecipeModel {
  const RecipeModel({
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

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  final String id;
  final String title;
  final String? description;
  final List<IngredientModel> ingredients;
  final List<String> instructions;
  final String? category;
  final int? prepTime;
  final int? cookTime;
  final int? servings;
  final int? calories;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}
