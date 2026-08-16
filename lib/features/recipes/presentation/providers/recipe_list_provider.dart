import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/features/favorites/presentation/providers/favorites_list_provider.dart';
import 'package:what_2_eat/features/recipes/data/datasources/recipe_local_data_source.dart';
import 'package:what_2_eat/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:what_2_eat/features/recipes/domain/usecases/list_recipes_usecase.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_state.dart';
import 'package:what_2_eat/shared/domain/entities/recipe.dart';

part 'recipe_list_provider.g.dart';

@Riverpod(keepAlive: true)
class RecipeListNotifier extends _$RecipeListNotifier {
  late final ListRecipesUseCase _listRecipesUseCase;
  late final RecipeRepository _recipeRepository;

  @override
  RecipeListUiState build() {
    _listRecipesUseCase = getIt<ListRecipesUseCase>();
    _recipeRepository = getIt<RecipeRepository>();

    final cached = _recipeRepository.getCachedRecipes();
    if (cached != null) {
      Future.microtask(() {
        _syncFavoriteIdsFromItems(cached.items);
        refresh();
      });
      return RecipeListUiState(
        items: cached.items,
        currentPage: cached.pagination.page,
        totalPages: cached.pagination.totalPages,
      );
    }

    Future.microtask(refresh);
    return const RecipeListUiState(isLoadingInitial: true);
  }

  Future<void> updateFilters({
    required String query,
    String? category,
  }) async {
    final trimmedQuery = query.trim();
    final cached = _recipeRepository.getCachedRecipes(
      query: trimmedQuery,
      category: category,
    );

    if (cached != null) {
      state = state.copyWith(
        query: trimmedQuery,
        category: category,
        clearCategory: category == null,
        items: cached.items,
        currentPage: cached.pagination.page,
        totalPages: cached.pagination.totalPages,
        clearFailure: true,
      );
      _syncFavoriteIdsFromItems(cached.items);
      await refresh();
      return;
    }

    state = state.copyWith(
      query: trimmedQuery,
      category: category,
      clearCategory: category == null,
      clearFailure: true,
      items: const [],
      currentPage: 0,
      totalPages: 0,
      isLoadingInitial: true,
    );
    await _loadPage(page: 1, append: false);
  }

  Future<void> refresh({bool showRefreshingIndicator = false}) async {
    final isSilent = !showRefreshingIndicator && state.items.isNotEmpty;

    if (showRefreshingIndicator) {
      state = state.copyWith(isRefreshing: true, clearFailure: true);
    } else if (!isSilent) {
      state = state.copyWith(isLoadingInitial: true, clearFailure: true);
    } else {
      state = state.copyWith(clearFailure: true);
    }

    await _loadPage(
      page: 1,
      append: false,
      silentFailure: isSilent,
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoadingInitial) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);
    await _loadPage(page: state.currentPage + 1, append: true);
  }

  Future<void> prependRecipe(Recipe recipe) async {
    if (state.query.trim().isEmpty && state.category == null) {
      final existingItems =
          state.items.where((item) => item.id != recipe.id).toList();
      state = state.copyWith(
        items: [recipe, ...existingItems],
        clearFailure: true,
      );
    }
  }

  void updateRecipeFavoriteStatus(
    String recipeId, {
    required bool isFavorite,
  }) {
    final updatedItems = state.items.map((recipe) {
      if (recipe.id != recipeId) {
        return recipe;
      }
      return recipe.copyWith(isFavorite: isFavorite);
    }).toList();

    state = state.copyWith(items: updatedItems);

    Recipe? updatedRecipe;
    for (final recipe in updatedItems) {
      if (recipe.id == recipeId) {
        updatedRecipe = recipe;
        break;
      }
    }

    updatedRecipe ??=
        getIt<RecipeRepository>().getCachedRecipeById(recipeId)?.copyWith(
              isFavorite: isFavorite,
            );

    if (updatedRecipe != null) {
      getIt<RecipeLocalDataSource>().addSingleRecipe(updatedRecipe);
    }
  }

  void _syncFavoriteIdsFromItems(List<Recipe> items) {
    ref
        .read(favoriteRecipeIdsNotifierProvider.notifier)
        .applyRecipeFavoriteFlags(items);
  }

  Future<void> _loadPage({
    required int page,
    required bool append,
    bool silentFailure = false,
  }) async {
    final trimmedQuery = state.query.trim();

    final result = await _listRecipesUseCase(
      ListRecipesParams(
        query: trimmedQuery.isEmpty ? null : trimmedQuery,
        category: state.category,
        page: page,
      ),
    );

    result.fold(
      (failure) {
        if (silentFailure && state.items.isNotEmpty) {
          state = state.copyWith(
            isLoadingInitial: false,
            isLoadingMore: false,
            isRefreshing: false,
          );
          return;
        }

        state = state.copyWith(
          isLoadingInitial: false,
          isLoadingMore: false,
          isRefreshing: false,
          failure: failure,
        );
      },
      (paginated) {
        final mergedItems = append
            ? [...state.items, ...paginated.items]
            : paginated.items;

        _syncFavoriteIdsFromItems(paginated.items);

        state = state.copyWith(
          items: mergedItems,
          currentPage: paginated.pagination.page,
          totalPages: paginated.pagination.totalPages,
          isLoadingInitial: false,
          isLoadingMore: false,
          isRefreshing: false,
          clearFailure: true,
        );
      },
    );
  }
}
