import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_2_eat/core/injection_container.dart';
import 'package:what_2_eat/features/recipes/domain/usecases/list_recipes_usecase.dart';
import 'package:what_2_eat/features/recipes/presentation/providers/recipe_list_state.dart';

part 'recipe_list_provider.g.dart';

@riverpod
class RecipeListNotifier extends _$RecipeListNotifier {
  @override
  RecipeListUiState build() {
    Future.microtask(refresh);
    return const RecipeListUiState(isLoadingInitial: true);
  }

  Future<void> updateFilters({
    required String query,
    String? category,
  }) async {
    state = state.copyWith(
      query: query,
      category: category,
      clearCategory: category == null,
      clearError: true,
      items: const [],
      currentPage: 0,
      totalPages: 0,
      isLoadingInitial: true,
    );
    await _loadPage(page: 1, append: false);
  }

  Future<void> refresh() async {
    if (state.items.isEmpty) {
      state = state.copyWith(
        isLoadingInitial: true,
        clearError: true,
      );
    } else {
      state = state.copyWith(isRefreshing: true, clearError: true);
    }

    await _loadPage(page: 1, append: false);
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoadingInitial) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);
    await _loadPage(page: state.currentPage + 1, append: true);
  }

  Future<void> _loadPage({
    required int page,
    required bool append,
  }) async {
    final trimmedQuery = state.query.trim();

    final result = await getIt<ListRecipesUseCase>()(
      ListRecipesParams(
        query: trimmedQuery.isEmpty ? null : trimmedQuery,
        category: state.category,
        page: page,
      ),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingInitial: false,
          isLoadingMore: false,
          isRefreshing: false,
          errorMessage: failure.message,
        );
      },
      (paginated) {
        final mergedItems = append
            ? [...state.items, ...paginated.items]
            : paginated.items;

        state = state.copyWith(
          items: mergedItems,
          currentPage: paginated.pagination.page,
          totalPages: paginated.pagination.totalPages,
          isLoadingInitial: false,
          isLoadingMore: false,
          isRefreshing: false,
          clearError: true,
        );
      },
    );
  }
}
