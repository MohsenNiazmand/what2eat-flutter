import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/core/constants/colors.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_detail_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_preview_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/recipe_detail_content.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/recipe_hero_image.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_loading_indicator.dart';
import 'package:what_2_eat/shared/presentation/widgets/error_retry_view.dart';

class RecipeDetailScreen extends HookConsumerWidget {
  const RecipeDetailScreen({
    required this.recipeId,
    this.resolveFavoriteStatus = true,
    super.key,
  });

  final String recipeId;
  final bool resolveFavoriteStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previewRecipe = ref.watch(recipePreviewProvider(recipeId));
    final detailAsync = ref.watch(recipeDetailProvider(recipeId));

    final recipe = detailAsync.valueOrNull ?? previewRecipe;

    if (recipe != null) {
      return _RecipeDetailBody(
        recipe: recipe,
        resolveFavoriteStatus: resolveFavoriteStatus,
      );
    }

    return detailAsync.when(
      loading: () => Scaffold(
        backgroundColor: cBackground,
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
              ),
              const Expanded(child: AppLoadingIndicator()),
            ],
          ),
        ),
      ),
      error: (error, _) {
        final message =
            error is StateError ? error.message : context.tr.genericError;

        return Scaffold(
          backgroundColor: cBackground,
          body: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                ),
                Expanded(
                  child: ErrorRetryView(
                    message: message,
                    onRetry: () {
                      ref.invalidate(recipeDetailProvider(recipeId));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      data: (loadedRecipe) => _RecipeDetailBody(
        recipe: loadedRecipe,
        resolveFavoriteStatus: resolveFavoriteStatus,
      ),
    );
  }
}

class _RecipeDetailBody extends HookWidget {
  const _RecipeDetailBody({
    required this.recipe,
    required this.resolveFavoriteStatus,
  });

  final Recipe recipe;
  final bool resolveFavoriteStatus;

  static const _expandedHeight = 350.0;
  static const _bodyOverlap = 30.0;
  static const _bodyTopRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scrollController = useScrollController();
    final isCollapsed = useState(false);
    final topPadding = MediaQuery.paddingOf(context).top;
    final collapseOffset = _expandedHeight - kToolbarHeight - topPadding;

    useEffect(
      () {
        void onScroll() {
          if (!scrollController.hasClients) return;
          final collapsed = scrollController.offset >= collapseOffset;
          if (isCollapsed.value != collapsed) {
            isCollapsed.value = collapsed;
          }
        }

        scrollController.addListener(onScroll);
        return () => scrollController.removeListener(onScroll);
      },
      [scrollController, collapseOffset],
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isCollapsed.value
          ? const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            )
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
      child: Scaffold(
        backgroundColor: cBackground,
        body: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverAppBar(
                  expandedHeight: _expandedHeight,
                  pinned: true,
                  stretch: true,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: cBackground,
                  automaticallyImplyLeading: false,
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 180),
                    opacity: isCollapsed.value ? 1 : 0,
                    child: Text(
                      recipe.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cTextPrimary,
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.zoomBackground,
                    ],
                    background: RecipeDetailHeroImage(
                      heroTag: recipe.id,
                      imageUrl: recipe.image,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Transform.translate(
                    offset: const Offset(0, -_bodyOverlap),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: cBackground,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(_bodyTopRadius),
                        ),
                      ),
                      child: RecipeDetailContent(recipe: recipe),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.paddingOf(context).bottom + 24,
                  ),
                ),
              ],
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    _FloatingGlassButton(
                      onPressed: () => context.pop(),
                      icon: Icons.arrow_back_rounded,
                    ),
                    const Spacer(),
                    _FloatingGlassFavoriteButton(
                      recipeId: recipe.id,
                      resolveFavoriteStatus: resolveFavoriteStatus,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingGlassButton extends StatelessWidget {
  const _FloatingGlassButton({
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: Colors.white.withValues(alpha: 0.22),
          shape: const CircleBorder(
            side: BorderSide(
              color: Color(0x66FFFFFF),
              width: 0.5,
            ),
          ),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Icon(
                icon,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingGlassFavoriteButton extends StatelessWidget {
  const _FloatingGlassFavoriteButton({
    required this.recipeId,
    required this.resolveFavoriteStatus,
  });

  final String recipeId;
  final bool resolveFavoriteStatus;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: Colors.white.withValues(alpha: 0.22),
          shape: const CircleBorder(
            side: BorderSide(
              color: Color(0x66FFFFFF),
              width: 0.5,
            ),
          ),
          child: SizedBox(
            width: 44,
            height: 44,
            child: FavoriteButton(
              recipeId: recipeId,
              resolveFavoriteStatus: resolveFavoriteStatus,
              inactiveIconColor: Colors.white,
              activeIconColor: cError,
            ),
          ),
        ),
      ),
    );
  }
}
