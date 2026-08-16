import 'package:what_2_eat/core/error/failures.dart';
import 'package:what_2_eat/shared/domain/entities/favorite.dart';

class FavoritesListUiState {
  const FavoritesListUiState({
    this.items = const [],
    this.isLoadingInitial = false,
    this.isRefreshing = false,
    this.failure,
  });

  final List<Favorite> items;
  final bool isLoadingInitial;
  final bool isRefreshing;
  final Failure? failure;

  bool get showEmptyState {
    return items.isEmpty &&
        !isLoadingInitial &&
        !isRefreshing &&
        failure == null;
  }

  FavoritesListUiState copyWith({
    List<Favorite>? items,
    bool? isLoadingInitial,
    bool? isRefreshing,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return FavoritesListUiState(
      items: items ?? this.items,
      isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }
}
