import 'package:what_2_eat/features/auth/data/models/user_model.dart';
import 'package:what_2_eat/features/favorites/data/models/favorite_model.dart';
import 'package:what_2_eat/features/preferences/data/models/preference_model.dart';
import 'package:what_2_eat/shared/data/models/ingredient_model.dart';
import 'package:what_2_eat/shared/data/models/pagination_model.dart';
import 'package:what_2_eat/shared/data/models/recipe_model.dart';
import 'package:what_2_eat/shared/data/models/recipe_options_model.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';
import 'package:what_2_eat/shared/domain/entities/ingredient.dart';
import 'package:what_2_eat/shared/domain/entities/paginated_result.dart';
import 'package:what_2_eat/shared/domain/entities/preference.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';
import 'package:what_2_eat/shared/domain/entities/user.dart';

extension UserModelX on UserModel {
  User toEntity() {
    return User(
      id: id,
      mobileNumber: mobileNumber,
      name: name,
      recipeOptions: recipeOptions?.toEntity(),
    );
  }
}

extension IngredientModelX on IngredientModel {
  Ingredient toEntity() {
    return Ingredient(name: name, amount: amount);
  }
}

extension RecipeModelX on RecipeModel {
  Recipe toEntity() {
    return Recipe(
      id: id,
      title: title,
      description: description,
      ingredients: ingredients.map((e) => e.toEntity()).toList(),
      instructions: instructions,
      category: category,
      prepTime: prepTime,
      cookTime: cookTime,
      servings: servings,
      calories: calories,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension PreferenceModelX on PreferenceModel {
  Preference toEntity() {
    return Preference(
      id: id,
      dietaryRestrictions: dietaryRestrictions,
      preferredCuisines: preferredCuisines,
      updatedAt: updatedAt,
    );
  }
}

extension FavoriteModelX on FavoriteModel {
  Favorite toEntity() {
    return Favorite(
      id: id,
      recipeId: recipeId,
      createdAt: createdAt,
      recipe: recipe?.toEntity(),
    );
  }
}

extension PaginationModelX on PaginationModel {
  Pagination toEntity() {
    return Pagination(
      page: page,
      limit: limit,
      total: total,
      totalPages: totalPages,
    );
  }
}
