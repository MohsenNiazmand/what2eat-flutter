import 'package:json_annotation/json_annotation.dart';
import 'package:what_2_eat/shared/domain/entities/recipe_options.dart';

part 'recipe_options_model.g.dart';

@JsonSerializable()
class RecipeOptionItemModel {
  const RecipeOptionItemModel({
    required this.id,
    required this.label,
    required this.isAvailable,
  });

  factory RecipeOptionItemModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeOptionItemModelFromJson(json);

  final String id;
  final String label;
  final bool isAvailable;

  Map<String, dynamic> toJson() => _$RecipeOptionItemModelToJson(this);
}

@JsonSerializable()
class RecipeOptionsModel {
  const RecipeOptionsModel({
    required this.countries,
    required this.dietaryPreferences,
  });

  factory RecipeOptionsModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeOptionsModelFromJson(json);

  final List<RecipeOptionItemModel> countries;
  final List<RecipeOptionItemModel> dietaryPreferences;

  Map<String, dynamic> toJson() => _$RecipeOptionsModelToJson(this);
}

extension RecipeOptionItemModelX on RecipeOptionItemModel {
  RecipeOptionItem toEntity() {
    return RecipeOptionItem(
      id: id,
      label: label,
      isAvailable: isAvailable,
    );
  }
}

extension RecipeOptionsModelX on RecipeOptionsModel {
  RecipeOptions toEntity() {
    return RecipeOptions(
      countries: countries.map((item) => item.toEntity()).toList(),
      dietaryPreferences:
          dietaryPreferences.map((item) => item.toEntity()).toList(),
    );
  }
}
