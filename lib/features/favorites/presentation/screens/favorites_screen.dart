import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';
import 'package:what_2_eat/features/favorites/presentation/widgets/favorite_list_tile.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesListNotifierProvider);

    Future<void> onRefresh() {
      return ref.read(favoritesListNotifierProvider.notifier).refresh();
    }

    Future<void> openFavorite(String recipeId, Recipe? recipe) async {
      await context.push(
        AppRoutes.recipeDetailPath(recipeId),
        extra: recipe,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.tr.favoritesTabTitle)),
      body: favoritesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          final message =
              error is StateError ? error.message : context.tr.errorTitle;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: onRefresh,
                    child: Text(context.tr.retry),
                  ),
                ],
              ),
            ),
          );
        },
        data: (favorites) {
          if (favorites.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: cPrimary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.tr.noFavoritesFound,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
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
    );
  }
}
