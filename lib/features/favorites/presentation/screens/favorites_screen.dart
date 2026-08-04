import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/constants/app_assets.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';
import 'package:what_2_eat/features/favorites/presentation/widgets/favorite_list_tile.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_provider.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_loading_indicator.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_primary_button.dart';
import 'package:what_2_eat/shared/presentation/widgets/error_retry_view.dart';
import 'package:what_2_eat/shared/presentation/widgets/gap.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesListNotifierProvider);
    final theme = Theme.of(context);

    Future<void> onRefresh() {
      return ref.read(favoritesListNotifierProvider.notifier).refresh();
    }

    Future<void> openFavorite(String recipeId, Recipe? recipe) async {
      await context.push(
        AppRoutes.recipeDetailPath(recipeId),
        extra: recipe,
      );
    }

    void goToRecipesTab() {
      ref.read(recipeListNotifierProvider.notifier).refresh();
      context.go(AppRoutes.home);
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: favoritesAsync.when(
          loading: () => const AppLoadingIndicator(),
          error: (error, _) {
            final message = error is StateError
                ? error.message
                : context.tr.genericError;

            return ErrorRetryView(
              message: message,
              onRetry: onRefresh,
            );
          },
          data: (favorites) {
            if (favorites.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.favsBg,
                        width: 220,
                        height: 220,
                      ),
                      Gap.v32(),
                      Text(
                        context.tr.noFavoritesFound,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: cTextSecondary,
                          height: 1.5,
                        ),
                      ),
                      Gap.v32(),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: cPrimary.withValues(alpha: 0.22),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: AppPrimaryButton(
                          label: context.tr.browseRecipes,
                          onPressed: goToRecipesTab,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 24),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final favorite = favorites[index];

                  return FavoriteListTile(
                    favorite: favorite,
                    onTap: () => openFavorite(
                      favorite.recipeId,
                      favorite.recipe,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
