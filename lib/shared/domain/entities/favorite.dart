import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class Favorite {
  const Favorite({
    required this.id,
    required this.recipeId,
    required this.createdAt,
    this.recipe,
  });

  final String id;
  final String recipeId;
  final DateTime createdAt;
  final Recipe? recipe;
}
