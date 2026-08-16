import 'package:hive_ce/hive.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

part 'favorite.g.dart';

@HiveType(typeId: 3)
class Favorite {
  const Favorite({
    required this.id,
    required this.recipeId,
    required this.createdAt,
    this.recipe,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String recipeId;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final Recipe? recipe;
}
