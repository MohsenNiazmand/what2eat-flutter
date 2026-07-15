// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_recipe_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateRecipeRequest _$GenerateRecipeRequestFromJson(
  Map<String, dynamic> json,
) => GenerateRecipeRequest(
  ingredients: (json['ingredients'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  tools: (json['tools'] as List<dynamic>?)?.map((e) => e as String).toList(),
  calorieLimit: (json['calorieLimit'] as num?)?.toInt(),
  servings: (json['servings'] as num?)?.toInt(),
);

Map<String, dynamic> _$GenerateRecipeRequestToJson(
  GenerateRecipeRequest instance,
) => <String, dynamic>{
  'ingredients': instance.ingredients,
  'tools': instance.tools,
  'calorieLimit': instance.calorieLimit,
  'servings': instance.servings,
};
