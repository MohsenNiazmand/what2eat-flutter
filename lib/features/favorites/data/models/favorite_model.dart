import 'package:json_annotation/json_annotation.dart';
import 'package:what_2_eat/shared/data/models/recipe_model.dart';

part 'favorite_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FavoriteModel {
  const FavoriteModel({
    required this.id,
    required this.recipeId,
    required this.createdAt,
    this.recipe,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  final String id;
  final String recipeId;
  final DateTime createdAt;
  final RecipeModel? recipe;

  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FavoriteListEnvelope {
  const FavoriteListEnvelope({
    required this.success,
    required this.data,
  });

  factory FavoriteListEnvelope.fromJson(Map<String, dynamic> json) =>
      _$FavoriteListEnvelopeFromJson(json);

  final bool success;
  final List<FavoriteModel> data;

  Map<String, dynamic> toJson() => _$FavoriteListEnvelopeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FavoriteEnvelope {
  const FavoriteEnvelope({
    required this.success,
    required this.data,
  });

  factory FavoriteEnvelope.fromJson(Map<String, dynamic> json) =>
      _$FavoriteEnvelopeFromJson(json);

  final bool success;
  final FavoriteModel data;

  Map<String, dynamic> toJson() => _$FavoriteEnvelopeToJson(this);
}

@JsonSerializable()
class AddFavoriteRequest {
  const AddFavoriteRequest({required this.recipeId});

  factory AddFavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFavoriteRequestFromJson(json);

  final String recipeId;

  Map<String, dynamic> toJson() => _$AddFavoriteRequestToJson(this);
}
