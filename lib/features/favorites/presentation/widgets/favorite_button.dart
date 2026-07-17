import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorite_toggle_provider.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';
import 'package:what_2_eat/shared/presentation/utils/toast_utils.dart';

class FavoriteButton extends ConsumerStatefulWidget {
  const FavoriteButton({
    required this.recipeId,
    this.resolveFavoriteStatus = true,
    super.key,
  });

  final String recipeId;
  final bool resolveFavoriteStatus;

  @override
  ConsumerState<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton> {
  @override
  void initState() {
    super.initState();
    if (widget.resolveFavoriteStatus) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ref.read(favoriteRecipeIdsNotifierProvider.notifier).loadIfNeeded();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteIds = ref.watch(favoriteRecipeIdsProvider);
    final toggleState = ref.watch(favoriteToggleNotifierProvider);
    final isFavorite = favoriteIds.contains(widget.recipeId);
    final isBusy = toggleState.isLoading;
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      onPressed: isBusy
          ? null
          : () async {
              final failure = await ref
                  .read(favoriteToggleNotifierProvider.notifier)
                  .toggle(
                    recipeId: widget.recipeId,
                    isCurrentlyFavorite: isFavorite,
                  );

              if (failure != null && context.mounted) {
                showFailureToast(context, failure);
              }
            },
      icon: AnimatedSwitcher(
        // Design rationale: Cross-fade heart states for lightweight feedback.
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
                color: isFavorite ? colorScheme.error : colorScheme.onSurface,
              ),
      ),
    );
  }
}
