import 'package:what_2_eat/shared/domain/entities/recipe_options.dart';

class User {
  const User({
    required this.id,
    required this.mobileNumber,
    this.name,
    this.recipeOptions,
  });

  final String id;
  final String mobileNumber;
  final String? name;
  final RecipeOptions? recipeOptions;
}
