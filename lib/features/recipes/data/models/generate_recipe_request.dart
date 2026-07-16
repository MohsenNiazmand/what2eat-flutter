import 'package:json_annotation/json_annotation.dart';

part 'generate_recipe_request.g.dart';

@JsonSerializable(includeIfNull: false)
class GenerateRecipeRequest {
  const GenerateRecipeRequest({
    this.countries,
    this.dietaryPreferences,
    this.ingredients,
    this.tools,
    this.exclusions,
    this.calorieLimit,
    this.servings,
    this.notes,
  });

  factory GenerateRecipeRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateRecipeRequestFromJson(json);

  final List<String>? countries;
  final List<String>? dietaryPreferences;
  final List<String>? ingredients;
  final List<String>? tools;
  final List<String>? exclusions;
  final int? calorieLimit;
  final int? servings;
  final String? notes;

  Map<String, dynamic> toJson() => _$GenerateRecipeRequestToJson(this);
}
