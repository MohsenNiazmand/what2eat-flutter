import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorite_toggle_provider.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    required this.recipeId,
    super.key,
  });

  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(favoritesListNotifierProvider);
    final favoriteIds = ref.watch(favoriteRecipeIdsProvider);
    final toggleState = ref.watch(favoriteToggleNotifierProvider);
    final isFavorite = favoriteIds.contains(recipeId);
    final isBusy = toggleState.isLoading;

    return IconButton(
      onPressed: isBusy
          ? null
          : () async {
              final failure = await ref
                  .read(favoriteToggleNotifierProvider.notifier)
                  .toggle(
                    recipeId: recipeId,
                    isCurrentlyFavorite: isFavorite,
                  );

              if (failure != null) {
                showFailureToast(failure);
              }
            },
      icon: isBusy
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? cError : null,
            ),
    );
  }
}
