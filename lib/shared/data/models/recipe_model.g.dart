// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  ingredients:
      (json['ingredients'] as List<dynamic>?)
          ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  instructions:
      (json['instructions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  category: json['category'] as String?,
  prepTime: (json['prepTime'] as num?)?.toInt(),
  cookTime: (json['cookTime'] as num?)?.toInt(),
  servings: (json['servings'] as num?)?.toInt(),
  calories: (json['calories'] as num?)?.toInt(),
  image: json['image'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
      'instructions': instance.instructions,
      'category': instance.category,
      'prepTime': instance.prepTime,
      'cookTime': instance.cookTime,
      'servings': instance.servings,
      'calories': instance.calories,
      'image': instance.image,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
