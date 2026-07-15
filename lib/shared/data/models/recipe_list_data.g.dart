// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeListData _$RecipeListDataFromJson(Map<String, dynamic> json) =>
    RecipeListData(
      items: (json['items'] as List<dynamic>)
          .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: PaginationModel.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$RecipeListDataToJson(RecipeListData instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination.toJson(),
    };

RecipeListEnvelope _$RecipeListEnvelopeFromJson(Map<String, dynamic> json) =>
    RecipeListEnvelope(
      success: json['success'] as bool,
      data: RecipeListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeListEnvelopeToJson(RecipeListEnvelope instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.toJson(),
    };

RecipeEnvelope _$RecipeEnvelopeFromJson(Map<String, dynamic> json) =>
    RecipeEnvelope(
      success: json['success'] as bool,
      data: RecipeModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeEnvelopeToJson(RecipeEnvelope instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.toJson(),
    };
