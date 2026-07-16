// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_options_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeOptionItemModel _$RecipeOptionItemModelFromJson(
  Map<String, dynamic> json,
) => RecipeOptionItemModel(
  id: json['id'] as String,
  label: json['label'] as String,
  isAvailable: json['isAvailable'] as bool,
);

Map<String, dynamic> _$RecipeOptionItemModelToJson(
  RecipeOptionItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'isAvailable': instance.isAvailable,
};

RecipeOptionsModel _$RecipeOptionsModelFromJson(Map<String, dynamic> json) =>
    RecipeOptionsModel(
      countries: (json['countries'] as List<dynamic>)
          .map((e) => RecipeOptionItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dietaryPreferences: (json['dietaryPreferences'] as List<dynamic>)
          .map((e) => RecipeOptionItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeOptionsModelToJson(RecipeOptionsModel instance) =>
    <String, dynamic>{
      'countries': instance.countries,
      'dietaryPreferences': instance.dietaryPreferences,
    };
