import 'package:json_annotation/json_annotation.dart';
import 'package:what_2_eat/shared/data/models/pagination_model.dart';
import 'package:what_2_eat/shared/data/models/recipe_model.dart';

part 'recipe_list_data.g.dart';

@JsonSerializable(explicitToJson: true)
class RecipeListData {
  const RecipeListData({
    required this.items,
    required this.pagination,
  });

  factory RecipeListData.fromJson(Map<String, dynamic> json) =>
      _$RecipeListDataFromJson(json);

  final List<RecipeModel> items;
  final PaginationModel pagination;

  Map<String, dynamic> toJson() => _$RecipeListDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RecipeListEnvelope {
  const RecipeListEnvelope({
    required this.success,
    required this.data,
  });

  factory RecipeListEnvelope.fromJson(Map<String, dynamic> json) =>
      _$RecipeListEnvelopeFromJson(json);

  final bool success;
  final RecipeListData data;

  Map<String, dynamic> toJson() => _$RecipeListEnvelopeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RecipeEnvelope {
  const RecipeEnvelope({
    required this.success,
    required this.data,
  });

  factory RecipeEnvelope.fromJson(Map<String, dynamic> json) =>
      _$RecipeEnvelopeFromJson(json);

  final bool success;
  final RecipeModel data;

  Map<String, dynamic> toJson() => _$RecipeEnvelopeToJson(this);
}
