import 'package:what_2_eat/shared/domain/entities/recipe.dart';

class RecipeListUiState {
  const RecipeListUiState({
    this.items = const [],
    this.query = '',
    this.category,
    this.currentPage = 0,
    this.totalPages = 0,
    this.isLoadingInitial = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.errorMessage,
  });

  final List<Recipe> items;
  final String query;
  final String? category;
  final int currentPage;
  final int totalPages;
  final bool isLoadingInitial;
  final bool isLoadingMore;
  final bool isRefreshing;
  final String? errorMessage;

  bool get hasMore => currentPage < totalPages;

  bool get showEmptyState {
    return items.isEmpty &&
        !isLoadingInitial &&
        !isRefreshing &&
        errorMessage == null;
  }

  RecipeListUiState copyWith({
    List<Recipe>? items,
    String? query,
    String? category,
    int? currentPage,
    int? totalPages,
    bool? isLoadingInitial,
    bool? isLoadingMore,
    bool? isRefreshing,
    String? errorMessage,
    bool clearError = false,
    bool clearCategory = false,
  }) {
    return RecipeListUiState(
      items: items ?? this.items,
      query: query ?? this.query,
      category: clearCategory ? null : (category ?? this.category),
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
