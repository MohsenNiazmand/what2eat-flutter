import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_detail_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/recipe_detail_content.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({
    required this.recipeId,
    this.initialRecipe,
    super.key,
  });

  final String recipeId;
  final Recipe? initialRecipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (initialRecipe != null) {
      return _RecipeDetailScaffold(recipe: initialRecipe!);
    }

    final recipeAsync = ref.watch(recipeDetailProvider(recipeId));

    return recipeAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text(context.tr.recipeDetailTitle)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) {
        final message =
            error is StateError ? error.message : context.tr.errorTitle;

        return Scaffold(
          appBar: AppBar(title: Text(context.tr.recipeDetailTitle)),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.invalidate(recipeDetailProvider(recipeId));
                    },
                    child: Text(context.tr.retry),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      data: (recipe) => _RecipeDetailScaffold(recipe: recipe),
    );
  }
}

class _RecipeDetailScaffold extends StatelessWidget {
  const _RecipeDetailScaffold({required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          FavoriteButton(recipeId: recipe.id),
        ],
      ),
      body: RecipeDetailContent(recipe: recipe),
    );
  }
}
