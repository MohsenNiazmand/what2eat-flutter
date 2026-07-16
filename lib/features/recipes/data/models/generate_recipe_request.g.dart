// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_recipe_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateRecipeRequest _$GenerateRecipeRequestFromJson(
  Map<String, dynamic> json,
) => GenerateRecipeRequest(
  countries: (json['countries'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  dietaryPreferences: (json['dietaryPreferences'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  ingredients: (json['ingredients'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  tools: (json['tools'] as List<dynamic>?)?.map((e) => e as String).toList(),
  exclusions: (json['exclusions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  calorieLimit: (json['calorieLimit'] as num?)?.toInt(),
  servings: (json['servings'] as num?)?.toInt(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$GenerateRecipeRequestToJson(
  GenerateRecipeRequest instance,
) => <String, dynamic>{
  if (instance.countries case final value?) 'countries': value,
  if (instance.dietaryPreferences case final value?)
    'dietaryPreferences': value,
  if (instance.ingredients case final value?) 'ingredients': value,
  if (instance.tools case final value?) 'tools': value,
  if (instance.exclusions case final value?) 'exclusions': value,
  if (instance.calorieLimit case final value?) 'calorieLimit': value,
  if (instance.servings case final value?) 'servings': value,
  if (instance.notes case final value?) 'notes': value,
};
