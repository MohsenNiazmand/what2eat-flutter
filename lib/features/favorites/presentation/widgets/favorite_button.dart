import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/core/constants/colors.dart';
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
