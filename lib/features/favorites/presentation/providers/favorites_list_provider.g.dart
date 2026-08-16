// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteRecipeIdsHash() => r'3d99a07996922da9f1646e3e954d9fe9c940a635';

/// See also [favoriteRecipeIds].
@ProviderFor(favoriteRecipeIds)
final favoriteRecipeIdsProvider = AutoDisposeProvider<Set<String>>.internal(
  favoriteRecipeIds,
  name: r'favoriteRecipeIdsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteRecipeIdsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteRecipeIdsRef = AutoDisposeProviderRef<Set<String>>;
String _$favoriteRecipeIdsNotifierHash() =>
    r'705a0c54af275b2aafe9c636d488d561c7f856e2';

/// See also [FavoriteRecipeIdsNotifier].
@ProviderFor(FavoriteRecipeIdsNotifier)
final favoriteRecipeIdsNotifierProvider =
    NotifierProvider<FavoriteRecipeIdsNotifier, Set<String>>.internal(
      FavoriteRecipeIdsNotifier.new,
      name: r'favoriteRecipeIdsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoriteRecipeIdsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FavoriteRecipeIdsNotifier = Notifier<Set<String>>;
String _$favoritesListNotifierHash() =>
    r'd9994ca10b384ffe35811ae04c5bb6b24a03d334';

/// See also [FavoritesListNotifier].
@ProviderFor(FavoritesListNotifier)
final favoritesListNotifierProvider =
    NotifierProvider<FavoritesListNotifier, FavoritesListUiState>.internal(
      FavoritesListNotifier.new,
      name: r'favoritesListNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoritesListNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FavoritesListNotifier = Notifier<FavoritesListUiState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
