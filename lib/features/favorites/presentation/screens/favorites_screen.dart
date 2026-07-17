import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';
import 'package:what_2_eat/features/favorites/presentation/widgets/favorite_list_tile.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_loading_indicator.dart';
import 'package:what_2_eat/shared/presentation/widgets/empty_state_view.dart';
import 'package:what_2_eat/shared/presentation/widgets/error_retry_view.dart';

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
            return EmptyStateView(
              icon: Icons.favorite_border_rounded,
              message: context.tr.noFavoritesFound,
            );
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 16),
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
