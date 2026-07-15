import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/features/recipes/domain/usecases/get_recipe_by_id_usecase.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

part 'recipe_detail_provider.g.dart';

@riverpod
Future<Recipe> recipeDetail(RecipeDetailRef ref, String id) async {
  final result = await getIt<GetRecipeByIdUseCase>()(
    GetRecipeByIdParams(id: id),
  );

  return result.fold(
    (failure) => throw StateError(failure.message),
    (recipe) => recipe,
  );
}
