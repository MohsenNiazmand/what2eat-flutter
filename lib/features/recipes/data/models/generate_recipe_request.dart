import 'package:json_annotation/json_annotation.dart';

part 'generate_recipe_request.g.dart';

@JsonSerializable()
class GenerateRecipeRequest {
  const GenerateRecipeRequest({
    required this.ingredients,
    this.tools,
    this.calorieLimit,
    this.servings,
  });

  factory GenerateRecipeRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateRecipeRequestFromJson(json);

  final List<String> ingredients;
  final List<String>? tools;
  final int? calorieLimit;
  final int? servings;

  Map<String, dynamic> toJson() => _$GenerateRecipeRequestToJson(this);
}
