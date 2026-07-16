import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:what_2_eat/config/router/routes.dart';
import 'package:what_2_eat/core/extensions/context_extensions.dart';
import 'package:what_2_eat/features/recipes/domain/constants/recipe_category_filters.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_provider.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_state.dart';
import 'package:what_2_eat/features/recipes/presentation/utils/recipe_category_labels.dart';
import 'package:what_2_eat/features/recipes/presentation/widgets/recipe_list_tile.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';
import 'package:what_2_eat/shared/presentation/utils/failure_message.dart';
import 'package:what_2_eat/shared/presentation/widgets/app_loading_indicator.dart';
import 'package:what_2_eat/shared/presentation/widgets/empty_state_view.dart';
import 'package:what_2_eat/shared/presentation/widgets/error_retry_view.dart';

class RecipeListScreen extends HookConsumerWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(recipeListNotifierProvider);
    final searchController = useTextEditingController(text: listState.query);
    final selectedCategory = useState<String?>(listState.category);
    final scrollController = useScrollController();
    final debounceTimer = useRef<Timer?>(null);

    useListenable(searchController);

    useEffect(
      () {
        void onScroll() {
          if (!scrollController.hasClients) return;

          final threshold = scrollController.position.maxScrollExtent - 200;
          if (scrollController.position.pixels >= threshold) {
            ref.read(recipeListNotifierProvider.notifier).loadMore();
          }
        }

        scrollController.addListener(onScroll);
        return () => scrollController.removeListener(onScroll);
      },
      [scrollController],
    );

    useEffect(
      () {
        void onSearchChanged() {
          debounceTimer.value?.cancel();
          debounceTimer.value = Timer(const Duration(milliseconds: 500), () {
            ref.read(recipeListNotifierProvider.notifier).updateFilters(
                  query: searchController.text,
                  category: selectedCategory.value,
                );
          });
        }

        searchController.addListener(onSearchChanged);
        return () {
          debounceTimer.value?.cancel();
          searchController.removeListener(onSearchChanged);
        };
      },
      [searchController, selectedCategory.value],
    );

    Future<void> onRefresh() {
      return ref.read(recipeListNotifierProvider.notifier).refresh();
    }

    void onCategoryChanged(String? category) {
      selectedCategory.value = category;
      ref.read(recipeListNotifierProvider.notifier).updateFilters(
            query: searchController.text,
            category: category,
          );
    }

    Future<void> openRecipe(Recipe recipe) async {
      await context.push(
        AppRoutes.recipeDetailPath(recipe.id),
        extra: recipe,
      );

      if (context.mounted) {
        await ref.read(recipeListNotifierProvider.notifier).refresh();
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.tr.recipesTabTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: context.tr.searchRecipesHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchController.clear();
                              ref
                                  .read(recipeListNotifierProvider.notifier)
                                  .updateFilters(
                                    query: '',
                                    category: selectedCategory.value,
                                  );
                            },
                          )
                        : null,
                  ),
                  onSubmitted: (value) {
                    debounceTimer.value?.cancel();
                    ref.read(recipeListNotifierProvider.notifier).updateFilters(
                          query: value,
                          category: selectedCategory.value,
                        );
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  key: ValueKey(selectedCategory.value),
                  initialValue: selectedCategory.value,
                  decoration: InputDecoration(
                    labelText: context.tr.categoryFilterLabel,
                    prefixIcon: const Icon(Icons.filter_list),
                  ),
                  items: [
                    DropdownMenuItem<String?>(
                      child: Text(context.tr.categoryAll),
                    ),
                    for (final option in RecipeCategoryFilters.all)
                      DropdownMenuItem<String?>(
                        value: option.apiValue,
                        child: Text(
                          recipeCategoryFilterLabel(context, option.apiValue),
                        ),
                      ),
                  ],
                  onChanged: onCategoryChanged,
                ),
              ],
            ),
          ),
          Expanded(
            child: _RecipeListBody(
              listState: listState,
              scrollController: scrollController,
              onRefresh: onRefresh,
              onRetry: () {
                ref.read(recipeListNotifierProvider.notifier).refresh();
              },
              onRecipeTap: openRecipe,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeListBody extends StatelessWidget {
  const _RecipeListBody({
    required this.listState,
    required this.scrollController,
    required this.onRefresh,
    required this.onRetry,
    required this.onRecipeTap,
  });

  final RecipeListUiState listState;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;
  final Future<void> Function(Recipe recipe) onRecipeTap;

  @override
  Widget build(BuildContext context) {
    if (listState.isLoadingInitial && listState.items.isEmpty) {
      return const AppLoadingIndicator();
    }

    if (listState.failure != null && listState.items.isEmpty) {
      return ErrorRetryView(
        message: failureMessage(context, listState.failure!),
        onRetry: onRetry,
      );
    }

    if (listState.showEmptyState) {
      return EmptyStateView(
        icon: Icons.restaurant_menu,
        message: context.tr.noRecipesFound,
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: listState.items.length + (listState.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= listState.items.length) {
            return const AppLoadingIndicator(padding: EdgeInsets.all(24));
          }

          final recipe = listState.items[index];
          return RecipeListTile(
            recipe: recipe,
            onTap: () => onRecipeTap(recipe),
          );
        },
      ),
    );
  }
}
