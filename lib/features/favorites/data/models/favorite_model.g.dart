// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      id: json['id'] as String,
      recipeId: json['recipeId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      recipe: json['recipe'] == null
          ? null
          : RecipeModel.fromJson(json['recipe'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipeId': instance.recipeId,
      'createdAt': instance.createdAt.toIso8601String(),
      'recipe': instance.recipe?.toJson(),
    };

FavoriteListEnvelope _$FavoriteListEnvelopeFromJson(
  Map<String, dynamic> json,
) => FavoriteListEnvelope(
  success: json['success'] as bool,
  data: (json['data'] as List<dynamic>)
      .map((e) => FavoriteModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FavoriteListEnvelopeToJson(
  FavoriteListEnvelope instance,
) => <String, dynamic>{
  'success': instance.success,
  'data': instance.data.map((e) => e.toJson()).toList(),
};

FavoriteEnvelope _$FavoriteEnvelopeFromJson(Map<String, dynamic> json) =>
    FavoriteEnvelope(
      success: json['success'] as bool,
      data: FavoriteModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteEnvelopeToJson(FavoriteEnvelope instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.toJson(),
    };

AddFavoriteRequest _$AddFavoriteRequestFromJson(Map<String, dynamic> json) =>
    AddFavoriteRequest(recipeId: json['recipeId'] as String);

Map<String, dynamic> _$AddFavoriteRequestToJson(AddFavoriteRequest instance) =>
    <String, dynamic>{'recipeId': instance.recipeId};
