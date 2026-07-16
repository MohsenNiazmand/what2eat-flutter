import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_detail_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/recipe_detail_content.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_loading_indicator.dart';
import 'package:what_2_eat/shared/presentation/widgets/error_retry_view.dart';

class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({
    required this.recipeId,
    this.initialRecipe,
    this.resolveFavoriteStatus = true,
    super.key,
  });

  final String recipeId;
  final Recipe? initialRecipe;
  final bool resolveFavoriteStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (initialRecipe != null) {
      return _RecipeDetailScaffold(
        recipe: initialRecipe!,
        resolveFavoriteStatus: resolveFavoriteStatus,
      );
    }

    final recipeAsync = ref.watch(recipeDetailProvider(recipeId));

    return recipeAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text(context.tr.recipeDetailTitle)),
        body: const AppLoadingIndicator(),
      ),
      error: (error, _) {
        final message =
            error is StateError ? error.message : context.tr.genericError;

        return Scaffold(
          appBar: AppBar(title: Text(context.tr.recipeDetailTitle)),
          body: ErrorRetryView(
            message: message,
            onRetry: () {
              ref.invalidate(recipeDetailProvider(recipeId));
            },
          ),
        );
      },
      data: (recipe) => _RecipeDetailScaffold(
        recipe: recipe,
        resolveFavoriteStatus: resolveFavoriteStatus,
      ),
    );
  }
}

class _RecipeDetailScaffold extends StatelessWidget {
  const _RecipeDetailScaffold({
    required this.recipe,
    required this.resolveFavoriteStatus,
  });

  final Recipe recipe;
  final bool resolveFavoriteStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          FavoriteButton(
            recipeId: recipe.id,
            resolveFavoriteStatus: resolveFavoriteStatus,
          ),
        ],
      ),
      body: RecipeDetailContent(recipe: recipe),
    );
  }
}
