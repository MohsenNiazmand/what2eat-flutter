import 'package:hive_ce/hive.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

part 'cached_recipe_list.g.dart';

@HiveType(typeId: 2)
class CachedRecipeList {
  CachedRecipeList({
    required this.recipes,
    required this.query,
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.total,
    this.category,
  });

  @HiveField(0)
  final List<Recipe> recipes;

  @HiveField(1)
  final String query;

  @HiveField(2)
  final String? category;

  @HiveField(3)
  final int currentPage;

  @HiveField(4)
  final int totalPages;

  @HiveField(5)
  final int limit;

  @HiveField(6)
  final int total;
}
