import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorite_toggle_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_preview_provider.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    required this.recipeId,
    this.resolveFavoriteStatus = true,
    this.inactiveIconColor,
    this.activeIconColor,
    super.key,
  });

  final String recipeId;
  final bool resolveFavoriteStatus;
  final Color? inactiveIconColor;
  final Color? activeIconColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = resolveFavoriteStatus
        ? ref.watch(recipeIsFavoriteProvider(recipeId))
        : false;
    final toggleState = ref.watch(favoriteToggleNotifierProvider);
    final isBusy = toggleState.isLoading;
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
      onPressed: isBusy
          ? null
          : () async {
              final failure = await ref
                  .read(favoriteToggleNotifierProvider.notifier)
                  .toggle(
                    recipeId: recipeId,
                    isCurrentlyFavorite: isFavorite,
                  );

              if (failure != null && context.mounted) {
                showFailureToast(context, failure);
              }
            },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: isBusy
            ? SizedBox(
                key: const ValueKey('busy'),
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
                ),
              )
            : Icon(
                key: ValueKey(isFavorite),
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: isFavorite
                    ? (activeIconColor ?? colorScheme.error)
                    : (inactiveIconColor ?? colorScheme.onSurface),
              ),
      ),
    );
  }
}
