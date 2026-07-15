import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/features/recipes/domain/usecases/generate_recipe_usecase.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

part 'generate_recipe_provider.g.dart';

@riverpod
class GenerateRecipeNotifier extends _$GenerateRecipeNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<Recipe?> generate({
    required List<String> ingredients,
    List<String>? tools,
    int? calorieLimit,
    int? servings,
  }) async {
    state = const AsyncValue.loading();

    final result = await getIt<GenerateRecipeUseCase>()(
      GenerateRecipeParams(
        ingredients: ingredients,
        tools: tools,
        calorieLimit: calorieLimit,
        servings: servings,
      ),
    );

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return null;
      },
      (recipe) {
        state = const AsyncValue.data(null);
        return recipe;
      },
    );
  }

  Failure? get lastFailure {
    final error = state.error;
    return error is Failure ? error : null;
  }
}
